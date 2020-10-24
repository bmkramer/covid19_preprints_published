# COVID-19 preprints linked to published journal articles (based on Crossref metadata)

*[work in progress]*

This repository contains code used to extract details of the COVID-19 related preprints that are linked to published journal articles, and visualize their distribution over time. Work building on [COVID-19 Preprints](https://github.com/nicholasmfraser/covid19_preprints) by [Nicholas Fraser](https://orcid.org/0000-0002-7582-6339) and [Bianca Kramer](https://orcid.org/0000-0002-5965-6560)


The process for collecting preprint metadata is documented fully [here](covid19_preprints_published.Rmd). In general terms, preprint metadata harvested from Crossref were enriched with data on linked published journal articles using the metadata field `relation.is-preprint-of` in Crossref.  

### A note on coverage
The coverage of links to published articles in Crossref is **expected to be incomplete** - not all preprint servers include such links in their metadata, and those that do might do so with a time delay and might miss cases where preprints are subsequently published as journal articles. 

Crossref notifies preprint servers of potential matches with published articles. It requires preprint servers to verify the links and add them to the metadata record of the preprint. 
(see [Crossref metadata: Posted content (includes preprints)](https://support.crossref.org/hc/en-us/articles/213126346-Posted-content-includes-preprints#assoc)), but uptake of this varies across preprint services.


For example, SRRN (n= 3772 COVID19-related preprints), Authorea (n= 729), and Scielo Preprints (n= 236) all do not have any links to published papers in their preprint metadata on Crossref. Figshare [only recently](https://twitter.com/figshare/status/1277516684358803461) started depositing these metadata for their preprint servers that use Crossref (ChemRXiv, TechRXiv). Both [bioRxiv](https://www.biorxiv.org/about/FAQ) and [medRxiv](https://www.medrxiv.org/about/FAQ), that do update Crossref metadata with links to published papers, mention there is usually a delay of a couple of weeks, and matches might be missed. 

**In short, the proportions shown here represent the lower bound of preprints that have subsequently been published as journal articles**. 

Among the preprint servers that do include links to published papers in their metadata, there are some interesting differences in the proportion of preprints linked to published papers (see figures below). These could reflect both technical workflows and publication practices, and will be interesting to investigate further. 

### Results
![](outputs/figures/covid19_preprints_published_week.png)

![](outputs/figures/covid19_preprints_published_day_cumulative.png)


 | 
:--------------------------:|:----------------------------|
![COVID-19 preprints per week - JMIR](outputs/figures/covid19_preprints_published_JMIR_week.png) | ![COVID-19 preprints per week - medRxiv](outputs/figures/covid19_preprints_published_medRxiv_week.png)

 | 
:--------------------------:|:----------------------------|
![COVID-19 preprints per week - bioRxiv](outputs/figures/covid19_preprints_published_bioRxiv_week.png) | ![COVID-19 preprints per week - ResearchSquare](outputs/figures/covid19_preprints_published_Research%20Square_week.png)

 |
:--------------------------:|:----------------------------|
![COVID-19 preprints per week](outputs/figures/covid19_preprints_published_Preprints.org_week.png) | ![COVID-19 preprints per week - OSF](outputs/figures/covid19_preprints_published_OSF_week.png)