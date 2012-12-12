from django.conf.urls import patterns, include, url
from ISSVote.settings import STATIC_ROOT

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    # url(r'^$', 'ISSVote.views.home', name='home'),
    # url(r'^ISSVote/', include('ISSVote.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    # url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),
    url(r'^accounts/login/$', 'django.contrib.auth.views.login',),
    url(r'^i18n/', include('django.conf.urls.i18n')),
    url(r'^static/(?P<path>.*)$', 'django.views.static.serve',{'document_root': STATIC_ROOT}),
    url(r'^iss/', include('ISSVoteApp.urls')),
)
