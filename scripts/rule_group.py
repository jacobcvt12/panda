# assign rule_group based on segment

def assign_rule(segment):
	lower_segment = segment.lower()
	if 'control' in lower_segment or lower_segment == 'null':
		return 'Control Group'					
	elif 'bk_' in lower_segment:
		return 'Blue Kai'						
	elif 'mr_points_message' in lower_segment:
		return 'MR Program Message'					
	elif 'service' in lower_segment or 'discover_utility' in lower_segment or lower_segment == 'level':
		return 'Member Level'					
	elif 'acquisition' in lower_segment or 'acquistion' in lower_segment or 'no_visa' in lower_segment:
		return 'CC Acquisition'					
	elif 'portfolio' in lower_segment or 'cardholder' in lower_segment or lower_segment == 'earn_utility_link' or 'ca_visa' in lower_segment:
		return 'CC Cardholder'					
	elif 'central' in lower_segment:
		return 'Promo Central'					
	elif '_benefits' in lower_segment:
		return 'Member Benefits'					
	elif 'stateresidence' in lower_segment or '_rs_' in lower_segment or '_rs-' in lower_segment or 'residence' in lower_segment or '_rs ' in lower_segment:
		return 'Residence-State'				
	elif 'cityresidence' in lower_segment or '_rc_' in lower_segment or '_rc-' in lower_segment:
		return 'Residence-City'					
	elif lower_segment == 'earn_use_1' or 'di_mp' in lower_segment or lower_segment == 'marketpropensity_di_bestmatch':
		return 'Destination Interest'			
	elif '_sh_' in lower_segment or '_sh-' in lower_segment:
		return 'Saved Hotels'				
	elif '_l3sd_' in lower_segment or '_l3sd-' in lower_segment or 'lastcitiesstayed' in lower_segment:
		return 'Last 3 Stayed Dest.'				
	elif '_l3srd' in lower_segment or '_l3srd-' in lower_segment or 'lastcitysearch' in lower_segment:
		return 'Last 3 Searched Dest.'				
	elif '_l3sm_' in lower_segment or '_l3sm-' in lower_segment:
		return 'Last 3 Stayed Hotels'					
	elif '_l3sb_' in lower_segment or '_l3sb-' in lower_segment:
		return 'Last 3 Stayed Brands'					
	elif '_gnd_' in lower_segment or '_gnd-' in lower_segment or ('homepage_destinations' in lower_segment and 'guidednav' in lower_segment):
		return 'Guided Nav. Dest.'					
	elif '_gnb_' in lower_segment or '_gnb-' in lower_segment:
		return 'Guided Nav. Brand'					
	elif lower_segment == 'earn_use_2' or '_hp_' in lower_segment or 'hotel' in lower_segment:
		return 'Gen. Purch. Hotel'					
	elif 'earnpref' in lower_segment or lower_segment == 'milesearner' or '_mi_' in lower_segment or '_pe_' in lower_segment:
		return 'Earning Preference'					
	elif '_ai' in lower_segment or lower_segment == 'ai':
		return 'Activity Interest'					
	elif '_mp' in lower_segment or lower_segment == 'mp' or 'genpurmarket' in lower_segment:
		return 'Gen. Purch. Market'					
	elif 'resortmarket' in lower_segment:
		return 'Resort Market'					
	elif '_di' in lower_segment or lower_segment == 'di' or 'destination_interest' in lower_segment:
		return 'Destination Interest'					
	elif '_mi_' in lower_segment or '_mi-' in lower_segment:
		return 'Earning Preference'			   
	elif 'brand' in lower_segment or '_bp_' in lower_segment or '_bp-' in lower_segment:
		return 'Gen. Purch. Brand'					
	elif '_neartermmkt' in lower_segment:
		return 'Near Term Market'					
	elif '_newtomkt' in lower_segment:
		return 'New to Market'				 
	elif 'golf_elite' in lower_segment:
	   return 'Elite Leisure'					
	elif '_everest_' in lower_segment or 'mobilecheckin' in lower_segment or 'mobilepilot' in lower_segment:
	   return 'Mobile App'					
	elif 'wailea' in lower_segment:
		return 'Wailea/Chase Promo'					
	elif 'giftcard' in lower_segment:
		return 'Gift Card Elite'					
	elif 'lufthansa' in lower_segment or 'iberia' in lower_segment or 'unitedrewardsplus' in lower_segment:
		return 'Airline Offer'					
	elif 'insiders' in lower_segment:
		return 'Insiders'					
	elif 'megabonus' in lower_segment:
		return 'MegaBonus'					
	else:
		return 'Other'

