from django.conf.urls import patterns, include, url
from django.contrib import admin
from django.conf import settings
from django.conf.urls.static import static
from panda import views

admin.autodiscover()

urlpatterns = patterns('',
    url(r'^admin/', include(admin.site.urls)),
    url(r'^$', views.index, name='index'),
    url(r'^register/$', views.register, name='register'),
	url(r'^login/$', views.user_login, name='login'),
    url(r'^logout/$', views.user_logout, name='logout'),
    url(r'^upload/$', views.upload, name='upload'),
	url(r'^query/$', views.run_query, name='query'),
	url(r'^view_data/$', views.view_data, name='view_data'),
) + static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
