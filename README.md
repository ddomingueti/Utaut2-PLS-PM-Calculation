# Utaut2-PLS-PM-Calculation
Scripts to calculate and export the results from the utaut2 model

<h2>About this repository</h2>

This is a set of scripts that I made in master degree (2019-2021) to calculate and get the results from a PLS-PM model. I've used an UTAUT2 model adapted from Nishi's work [1] - an adaptation in the brazillian cultural context of the original Venkatesh's UTAUT2 model [2]. Some variables and constructs were removed due the research nature (social influence, user overall experience, schooling, household incomes, habit and use behaviour). I aimed to understand the behavioral intention towards a new technological artefact for nursing education.

<h2>How to use</h2>

This repository includes two scripts - preprocessing.py and Utau2_Calculation.R. You need to change some variable contents to adequate both of them to your needs - that is, put the correct dataset model and properties. The files are commented as well. That being said, here are the variables you can change and a few considerations about both scripts:

<i>preprocessing.py</i>
<ul>
  <li>Data mapping: it is meant to change your categorical scale value to integer values. E.g., from ['low', 'medium' and 'high'] to ['0', '1', and '2']. Create your own definitions and add them with "append" function in the "data_maps" variable;</li>
  <li>Original file name: the original dataset to be processed; </li>
  <li>Processed file name: the output/input file name to be scaled and/or normalized; </li>
  <li>Normalized file name:the output/input file name to be scaled and/or normalized; </li>
  <li>The standard behaviour is to run the preprocessing procedure, followed by the normalization and the standardization process. <b><i>You should comment whatever you do not need to execute at the end of the file!</i></b></li>
</ul>

<i>Utaut2_Calculation.R</i>
<ul>
  <li>It is important to set the correct dataset name in the main script section (utaut2_data variable);</li>
  <li>Set the measurement model according the SemInR library sintax (utaut2_mm variable)<b>*</b>;</li>
  <li>Set the structural model according the SemInR library sintax (utaut2_sm variable)<b>*</b>;</li>
  <li>The script calculates the PLS-model estimation, and further the Bootstrap-model estimation. You should comment the bootstrap section if you do not intent do use it;</li>
  <li>The results are exported to CSV files - regarding all the parameters given by SemInR library - and a PDF file containing the final model calculation. These files will be located in "PLS_Estimation" and "Bootstrap_Estimation" folders (automatically created if not exists). <b>Caution: the CSV files will be overwritten if already exists!</b></li>
  <li>It is possible to run in your favourite IDE or online notebook if you want.</li>
</ul>

The input files from both scripts are CSV files in the standard format (use "," as separator and "." as a decimal value separation, e.g., 2.2). This pattern is the same in the results' files. Example of input file:
<p>"exde1,exde2,exde3,exde4,exes1,(...)</p>
<p>1,1,1,1,1, (...)</p>
<p>2,2,2,2,2, (...)</p>
<p>(...)"</p>

<b><i>*Keep in mind to change to your current model and your current dataset format, if not intend to use the same as I did.</i></b>

<h2>Dependencies and installation</h2>
The preprocessing script uses <a href="https://pandas.pydata.org/">pandas</a> and <a href="https://scikit-learn.org/">Sci-kit Learn</a>.
The Utaut2 calculation script uses the libraries <a href="https://github.com/sem-in-r/seminr">SemInR</a> and DiagrammeR.

Installation commands (if not working, reffer to their oficial websites):
<ul>
<li><i>pip install pandas</i></li>
<li><i>pip install -U scikit-learn</i></li>
<li><i>install.packages("seminr")</i></li>
<li><i>install.packages("DiagrammeR")</i></li>
</ul>
After installing the dependencies, open the scripts in your editor/ide, make the necessary changes and execute. The R script will ask for its dependencies if not installed.

The datasets and the scripts are meant to be in the same folder. If not, change it accordingly in the scripts (or move the datasets).

<h2> References </h2>
<p>[1] NISHI, J. M. A (re) construção do modelo UTAUT 2 em contexto brasileiro. Tese (Doutorado). Universidade Federal de Santa Maria, 2017. 
<p>[2] VENKATESH, V; THONG J. Y; XU, X. Consumer acceptance and use of information technology: extending the unified theory of acceptance and use of technoglogy. <i>Mis quaterly</i>, JSTOR, p. 157-178, 2012.

<h2> License </h2>
This work is licensed as MIT license.
