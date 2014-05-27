from django.template import RequestContext
from django.shortcuts import render_to_response

def index(request):
	context = RequestContext(request)
	context_dict = {'message' : 'I am a bold font!'}
	return render_to_response('auto_panda/index.html', context_dict, context)
