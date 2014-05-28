from django.conf.urls import patterns, url
from auto_panda import views

urlpatterns = patterns('',
	url(r'^$', views.index, name='index'),
	url(r'^register/$', views.register, name='register'),
	url(r'^login/$', views.user_login, name='login'),
	url(r'^logout/$', views.user_logout, name='logout'),
	url(r'^upload/$', views.upload, name='upload'),
	url(r'ajax-upload/$', views.import_uploader, name='my_ajax_upload'),
)
