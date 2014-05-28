from django import forms
from auto_panda.models import UserProfile
from django.contrib.auth.models import User

class UserForm(forms.ModelForm):
	password = forms.CharField(widget=forms.PasswordInput())

	class Meta:
		model = User
		fields = ('username', 'email', 'password')

class UserProfileForm(forms.ModelForm):
	class Meta:
		model = UserProfile
		fields = ('website', 'picture')
		
class DocumentForm(forms.Form):
	docfile = forms.FileField(
		label='Select a file',
		help_text='max. 42 megabytes'
	)
