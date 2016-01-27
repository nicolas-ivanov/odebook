## -*- coding: utf-8 -*-

<%
import sys
sys.path.insert(0, '.')
# Allow imports from local dir to import nesode and odebook

import matplotlib
matplotlib.use('Agg')
# Need this to plot pictures without graphical backend

import nesode as no
from odebook import needfigure, savefigs,mkfig
import odebook as book 
%>

<%def name="begin_question()">
## sphinx doesn't allow quizes inside questions
% if FORMAT == 'sphinx':
__Контрольный вопрос.__ 
% else:
!bquestion Контрольный вопрос
%endif
</%def>

<%def name="end_question()">
% if FORMAT != 'sphinx':
!equestion
%endif
</%def>
