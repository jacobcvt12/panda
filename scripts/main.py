# imports
from csv import reader
from datetime import datetime
from glob import glob
from os import pardir
from os.path import join, abspath
from re import sub
from dicts import page_group_dict, site_dict
from rule_group import assign_rule
from sqlite3 import connect, OperationalError, IntegrityError
from time import strftime as date


# global variables
path = pardir
db_path = abspath(join(path, 'data', 'panda.db'))
conn = connect(db_path, timeout=30)
c = conn.cursor()

# functions
def daily_upload(file):
	'''parses and uploads text from csv to database'''
	# open text file
	f = open(join(path, 'files', 'extracts', file), 'rb')
	
	# set read to False to skip first few rows
	# initialize to_db to append to
	read = False
	to_db = []
		
	for row in reader(f):
		if not read:
			# check if this is the data header
			try:
				if row[0] == 'Date' and 'instances' in row[2].lower():
					read = True
			except IndexError:
				# index error on an empty row or row with less than 3 items
				pass
		
		else:
			# check if there are bookings, impressions,
			# or clicks before proceeding
			if sum([int(n) for n in row[2:6]]):
				# perform HTML clean up
				row[1] = row[1].replace('%3A', ':').replace('%7C', '|').replace('%3D', '=').replace('%20', '')
				
				# clean up date
				excel_date = datetime(1899, 12, 31)
				date_dt = datetime.strptime(row[0], '%b %d, %Y')
				
				if datetime(2014, 3, 15) <= date_dt <= datetime(2014, 4, 17):
					row[1] = sub(":personalizedPlacement(-[0-9]{1,}){3}", 
					            "", row[1])
				
				row[0] = date_dt.strftime('%Y-%m-%d')
				excel_serial = str((date_dt - excel_date).days)
				
				# emulate function of column A in excel workbook 
				# by combining (modified) date and link
				row = [excel_serial + row[1]] + row
				
				# prk parsing
				prk = row[2]
				if prk == '' or prk == 'None':
					row = row + [''] * 6
				else:					
					prk_split = prk.split('|')
					page = prk_split[0]
					segment = prk_split[1]
					page_section = \
						prk_split[2].split('pageSection=')[1].split(':')[0]
					placement = prk_split[2].split('placement=')[1]
					page_section_placement = prk_split[2]
					content_id = prk_split[3]
			
					row = row + [page, segment, page_section, placement, \
								 page_section_placement, content_id]									
				
				# add categories and groupings
				# page_group_dict imported from dicts.py
				page_group = "Other"
				
				for key in page_group_dict:
					if key in page.lower():
						page_group = page_group_dict[key]
						break
						
				if 'ritz' in page:
					rewards_program = "RCR"
				else:
					rewards_program = "MR"
				
				# assign rule_group based on segment
				rule_group = assign_rule(segment)
				
				control_group_key = str(date_dt.year) + '_' + \
					str(excel_date.month) + '_' + str(excel_date.day) + '_' +\
					page_section + '_' + placement
					
				# site_dict imported from dicts.py
					
				site = 'Other'
				
				for key in site_dict:
					if key in page:
						site = site_dict[key]
						break
						
				if "ControlGroup" in segment:
					department = "TBD"
				elif segment in ('', 'None') or '_' not in segment:
					department = 'Unavailable'
				else:
					department = segment.split('_')[0]
					
				row = row + [page_group, rewards_program, rule_group, 
					control_group_key, site, department]
										
				# append data to to_db
				to_db.append(row)
		
	# close text file
	f.close()
	
	# insert rows of csv into table mrlp
	str_SQL = 'INSERT INTO mrlp (ComboKey, Date, Personalization_Rule_Key, Instances, Link_Impressions, Bookings, Revenue, Bookings_Participation, Revenue_Participation, Rewards_Enrollments, Credit_Card_Apps, Hotel_Availability_Search_Visits, Promo_Registrations, Page, Segment, PageSection, Placement, PageSectionPlacement, ContentID, Page_Group, Rewards_Program, Rule_Group, ControlGroupKey, Site, Department) VALUES ' + str(tuple(['?'] * 25)).replace("'", '') + ';'
	c.executemany(str_SQL, to_db)
	conn.commit()
	
	row_count = len(to_db)
	tbl_upload_date = date('%Y-%d-%m')
	
	# insert file name (and info) into table uploaded so that panda
	# won't try to upload it again
	c.execute("INSERT INTO uploaded (file, upload_date, row_count) VALUES ('%s', '%s', %d);" \
		% (file, tbl_upload_date, row_count))
	conn.commit()
	
def execute_sql(sql_file):
	'''executes file of queries against database'''
	f = open(join(path, 'sql', sql_file), 'r')
	sql = f.read()
	try:
		c.executescript(sql)
		conn.commit()
	except OperationalError:
		print 'A problem occurred while executing %s' % sql_file
		
	f.close()

# main
if __name__ == '__main__':
	# get previously uploaded files
	conn.text_factory = str
	
	###################
	# REMOVE THIS     #
	# FOR DEVELOPMENT #
	###################
	
	print 'Deleting old uploads...'
	c.execute("DELETE FROM uploaded;")
	c.execute("DELETE FROM mrlp;")
	conn.commit()
	
	print 'Checking for previously uploaded files...'
	query = c.execute('SELECT file FROM uploaded;')
	uploaded_files = [f[0] for f in query.fetchall()]
	
	execute_sql('create_visits_to_personalized.sql')
	
	# initialize list of files that user agrees to upload
	usr_upload = []
	
	# glob through visits
	for file in glob(join(path, 'files', 'visits', '*.txt')):
		# get file name from full path
		file_name = file.split('\\')[-1]
		
		if file_name not in uploaded_files:
			f = open(join(path, 'files', 'visits', '%s' % file_name), 'rb')
			print 'Uploading %s...' % file_name
			row_count = 0
			
			for row in reader(f):
				values = ','.join(["'" + row[0] + "'"] + row[1:])
				
				sql = "INSERT INTO Visits_to_all_Personalized_Pages" + \
					  "(Date, MRLP_VISIT, MYA_Overview_Visit, " + \
					  "MRLP_and_MYA_Overview, Earn_No_MRLP_MYA, " + \
					  "Use_No_MRLP_MYA, Trip_Planner_No_MRLP_MYA, " + \
					  "Deals_No_MRLP_MYA_Use) VALUES (%s);" % values
				
				try:
					c.execute(sql)
					conn.commit()
				except IntegrityError:
					print "Duplicate dates in table (Ignoring second date)"
				
				row_count += 1
			
			tbl_upload_date = date('%Y-%d-%m')
			
			# insert file name (and info) into table uploaded so that panda
			# won't try to upload it again
			c.execute("INSERT INTO uploaded (file, upload_date, row_count) VALUES ('%s', '%s', %d);" \
				% (file_name, tbl_upload_date, row_count))
			conn.commit()
		
	# glob through csvs
	for file in glob(join(path, 'files', 'extracts', '*.csv')):
		# get file name from full path
		file_name = file.split('\\')[-1]
		
		# don't prompt for previously uploaded files
		if file_name not in uploaded_files:
			usr_upload.append(file_name)
			print '\nUploading %s...' % file_name
			daily_upload(file_name)
	
	# if user has uploaded files, run queries
	if len(usr_upload):
		# Run update queries
		print '\n\n\nRunning step 3c: Control Dept Lookup (Non-Deals LP)'
		execute_sql('qry_step_3c-control_dept_non_deal.sql')
		print 'Running step 3d: Control Dept (Non-Deals LP)'
		execute_sql('qry_step_3d-update_control_dept_non_deal.sql')
		print 'Running step 3dd: Update Control Dept (Deals LP:4-2)'
		execute_sql('qry_step_3dd-update_control_dept_deals.sql')
		print 'Running step 3dd: Update Trip Insp & MYA Control Dept'
		execute_sql('qry_step_3dd-update_trip_insp_mya.sql')
		print 'Running step 4: add link description'
		execute_sql('qry_step_4-add_link_desc_new.sql') 
		print 'Running step 6'
		execute_sql('qry_step_6-misc_query_link.sql') 
		print 'Running step 7'
		execute_sql('qry_step_7-misc_query_link_personalized.sql')
		
		# Run Populate Message Type Queries
		print '\n\n\nRunning update link data 01'
		execute_sql('update_link_data_01_segmented_targeted.sql')
		print 'Running update link data data 02a'
		execute_sql('update_link_data_02a-personalized_msgs_MRLP.sql')
		print 'Running update link data data 02b'
		execute_sql('update_link_data_02b-personalized_msgs_deals.sql')
		print 'Running update link data data 02c'
		execute_sql('update_link_data_02c-personalized_msgs_homepage.sql')
		print 'Running update link data data 02d'
		execute_sql('update_link_data_02d-segmented_msgs_homepage.sql')
		print 'Running update link data data 02e'
		execute_sql('update_link_data_02e-segmented_mobile_app_mrlp.sql')
		print 'Running update link data data 03a'
		execute_sql('update_link_data_03a-segmented_earning_pref.sql')
		print 'Running update link data data 03b'
		execute_sql('update_link_data_03b-update_earn_control_group.sql')
		print 'Running update link data data 03c'
		execute_sql('update_link_data_03c-segment_targeted_cg_in_pers_placements.sql')
		print 'Running update link data data 04'
		execute_sql('update_link_data_04-personalized_mya_etc.sql')
		print 'Running update link data data 04c'
		execute_sql('update_link_data_04c-personalized_earn_&_use.sql')
		print 'Running update link data data 05'
		execute_sql('update_link_data_05-segmented_msgs.sql')
		print 'Running update link data data 07'
		execute_sql('update_link_data_07-placement_name_(add).sql')
		print 'Running update link data data 08'
		execute_sql('update_link_data_08-calc_link_imp_adj.sql')
		print 'Running update link data data 10'
		execute_sql('update_link_data_10-add_summary_key.sql')
		
		# Deals LP Control Group Assignment
		print '\n\n\nRunning deals lp qry-step 5b'
		execute_sql('deals_lp_qry-step_5b_update_meos_to_mr_dept.sql')
		print 'Running deals lp qry-step 6'
		execute_sql('deals_lp_qry-step_6_check_all_assigned.sql')
		
		# Visit Level Impression Calculations
		# print '\n\n\nRunning append visit data'
		# execute_sql('append_visit_data.sql')
		# print 'Running personalization db'
		# execute_sql('personalization_db.sql')
		# print 'Running qry visits step 1'
		# execute_sql('qry-visits_step_1-impr_sum_by_placement.sql')
		# print 'Running qry visits step 2'
		# execute_sql('qry-visits_step_2-max_impr_by_day_and_page.sql')
		# print 'Running qry visits step 3'
		# execute_sql('qry-visits_step_3-impr_sum_by_page_and_day.sql')
		# print 'Running qry visits step 4'
		# execute_sql('qry-visits_step_4-add_impression_data.sql')
		
	
	# close connection to database
	conn.close()