from django.template import RequestContext
from django.shortcuts import render_to_response
from django.contrib.auth import authenticate, login, logout
from django.http import HttpResponseRedirect, HttpResponse
from django.contrib.auth.decorators import login_required
from django.middleware.csrf import get_token
from auto_panda.forms import UserForm, UserProfileForm
from ajaxuploader.views import AjaxFileUploader

def index(request):
	context = RequestContext(request)
	return render_to_response('auto_panda/index.html', {}, context)

def register(request):
	context = RequestContext(request)
	registered = False

    # If it's a HTTP POST, we're interested in processing form data.
	if request.method == 'POST':
		user_form = UserForm(data=request.POST)
		user_form.fields['username'].help_text = None
		
		if user_form.is_valid():
			user = user_form.save()
			user.set_password(user.password)
			user.save()
			
			registered = True

		else:
			print user_form.errors

	else:
		user_form = UserForm()
		user_form.fields['username'].help_text = None

	return render_to_response(
			'auto_panda/register.html',
			{'user_form': user_form, 'registered': registered},
			context)

def user_login(request):
	context = RequestContext(request)
	
	if request.method == 'POST':
		username = request.POST['username']
		password = request.POST['password']
		user = authenticate(username=username, password=password)
		
		if user:
			if user.is_active:
				login(request, user)
				return HttpResponseRedirect('/auto_panda/')
			else:
				return HttpResponse("Your account is disabled.")
		else:
			print "Invalid login details: {0}, {1}".format(username, password)
			return HttpResponse("Invalid login details supplied.")
				
	else:
		return render_to_response('auto_panda/login.html', {}, context)
		
# @login_required
def upload(request):
	csrf_token = get_token(request)
	context = RequestContext(request)
	return render_to_response('auto_panda/upload.html', 
		{'csrf_token' : csrf_token}, context)

import_uploader = AjaxFileUploader()	
	
@login_required
def user_logout(request):
	logout(request)
	return HttpResponseRedirect('/auto_panda/')