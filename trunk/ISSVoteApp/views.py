# Create your views here.
from django.shortcuts import get_object_or_404, render_to_response
#from django.http import HttpResponseRedirect, HttpResponse
from django.core.context_processors import csrf
#from django.core.urlresolvers import reverse
#from django.template import RequestContext
#from django.contrib.auth.models import User
from django.contrib.auth.decorators import login_required
from ISSVoteApp.models import *
#from django.utils.translation import ugettext as _

def add_csrf(request, **kwargs):
    """Add CSRF to dictionary."""
    d = dict(user=request.user, **kwargs)
    d.update(csrf(request))
    return d

@login_required
def votepage(request):
    return render_to_response('issvoteapp/votepage.html',add_csrf(request))
