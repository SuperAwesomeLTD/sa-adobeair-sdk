import sys
import os
extensions = []
templates_path = ['_templates']
source_suffix = '.rst'
master_doc = 'index'
project = u'Adobe AIR SDK'
copyright = u'2016, SuperAwesome Ltd'
author = u'Gabriel Coman'
version = u'3.1.6'
release = u'3.1.6'
language = None
exclude_patterns = []
show_authors = True
pygments_style = 'sphinx'
todo_include_todos = False
html_theme = 'sphinx_rtd_theme'
html_theme_options = {"logo_only":True}
html_theme_path = ["themes",]
html_logo = 'themeres/logo.png'
html_static_path = ['_static']
htmlhelp_basename = 'SAAdobeAIRSDKdoc'
latex_elements = {}
latex_documents = [
    (master_doc, 'SAAdobeAIRSDK.tex', u'SAAdobeAIRSDK Documentation', u'Gabriel Coman', 'manual'),
]
man_pages = [
    (master_doc, 'saadobeairsdk', u'SAAdobeAIRSDK Documentation', [author], 1)
]
texinfo_documents = [
    (master_doc, 'SAAdobeAIRSDK', u'SAAdobeAIRSDK Documentation', author, 'SAAdobeAIRSDK', 'One line description of project.', 'Miscellaneous'),
]
html_context = {
    'all_versions' : [u'3.1.6'],
    'domain': 'AwesomeAds',
    'sourcecode': 'https://github.com/SuperAwesomeLTD/sa-adobeair-sdk'
}
