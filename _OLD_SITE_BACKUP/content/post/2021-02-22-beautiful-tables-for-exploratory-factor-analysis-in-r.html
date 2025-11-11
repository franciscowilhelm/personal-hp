---
title: Beautiful Tables for Exploratory Factor Analysis in R
author: Francisco Wilhelm
date: '2021-02-22'
slug: exploratory-factor-analysis-table
categories: []
tags:
  - R
  - statistics
image:
  caption: ''
  focal_point: ''
output:
  html_document:
    df_print: kable
---

<script src="/rmarkdown-libs/header-attrs/header-attrs.js"></script>


<p>The <code>psych</code> package for R provides great utilities for exploratory factor analysis (EFA). However, the way <code>psych</code> displays the results does not take advantage of visual cues to make grasping the factor solutions easier, nor is it straightforward to display the results in a way that can be shared easily with others.
Several solutions to the problem have been proposed, such as the LaTeX-based <a href="http://personality-project.org/r/psych/help/df2latex.html"><code>psych::df2latex()</code></a> or an implementation in the sjPlot package <code>sjPlot::fa_tab()</code>. Because these solutions have some drawbacks, here’s another take on the issue.</p>
<p>The solution I present here is consistent with the tidyverse and builds on the highly flexible and powerful <code>gt</code> package to provide beautiful and highly customizable tables that can be used in R Markdown approaches.</p>
<div id="factor-analysis-example" class="section level2">
<h2>Factor Analysis Example</h2>
<p>We need several packages to get started:</p>
<pre class="r"><code>library(psych)
library(tidyverse)
library(gt)</code></pre>
<p>As an example we use the IPIP Big Five Inventory from the <code>psych</code> package. First we run a factor analysis; I will not go into details here as these are discussed in-depth in the psych package and EFA best practice papers.</p>
<pre class="r"><code>res &lt;- fa(psychTools::bfi[1:25],5)</code></pre>
<p>The standard way to display the EFA results are not very clean or legible inside a markdown output.</p>
<pre class="r"><code>print(res)</code></pre>
<pre><code>## Factor Analysis using method =  minres
## Call: fa(r = psychTools::bfi[1:25], nfactors = 5)
## Standardized loadings (pattern matrix) based upon correlation matrix
##      MR2   MR1   MR3   MR5   MR4   h2   u2 com
## A1  0.21  0.17  0.07 -0.41 -0.06 0.19 0.81 2.0
## A2 -0.02  0.00  0.08  0.64  0.03 0.45 0.55 1.0
## A3 -0.03  0.12  0.02  0.66  0.03 0.52 0.48 1.1
## A4 -0.06  0.06  0.19  0.43 -0.15 0.28 0.72 1.7
## A5 -0.11  0.23  0.01  0.53  0.04 0.46 0.54 1.5
## C1  0.07 -0.03  0.55 -0.02  0.15 0.33 0.67 1.2
## C2  0.15 -0.09  0.67  0.08  0.04 0.45 0.55 1.2
## C3  0.03 -0.06  0.57  0.09 -0.07 0.32 0.68 1.1
## C4  0.17  0.00 -0.61  0.04 -0.05 0.45 0.55 1.2
## C5  0.19 -0.14 -0.55  0.02  0.09 0.43 0.57 1.4
## E1 -0.06 -0.56  0.11 -0.08 -0.10 0.35 0.65 1.2
## E2  0.10 -0.68 -0.02 -0.05 -0.06 0.54 0.46 1.1
## E3  0.08  0.42  0.00  0.25  0.28 0.44 0.56 2.6
## E4  0.01  0.59  0.02  0.29 -0.08 0.53 0.47 1.5
## E5  0.15  0.42  0.27  0.05  0.21 0.40 0.60 2.6
## N1  0.81  0.10  0.00 -0.11 -0.05 0.65 0.35 1.1
## N2  0.78  0.04  0.01 -0.09  0.01 0.60 0.40 1.0
## N3  0.71 -0.10 -0.04  0.08  0.02 0.55 0.45 1.1
## N4  0.47 -0.39 -0.14  0.09  0.08 0.49 0.51 2.3
## N5  0.49 -0.20  0.00  0.21 -0.15 0.35 0.65 2.0
## O1  0.02  0.10  0.07  0.02  0.51 0.31 0.69 1.1
## O2  0.19  0.06 -0.08  0.16 -0.46 0.26 0.74 1.7
## O3  0.03  0.15  0.02  0.08  0.61 0.46 0.54 1.2
## O4  0.13 -0.32 -0.02  0.17  0.37 0.25 0.75 2.7
## O5  0.13  0.10 -0.03  0.04 -0.54 0.30 0.70 1.2
## 
##                        MR2  MR1  MR3  MR5  MR4
## SS loadings           2.57 2.20 2.03 1.99 1.59
## Proportion Var        0.10 0.09 0.08 0.08 0.06
## Cumulative Var        0.10 0.19 0.27 0.35 0.41
## Proportion Explained  0.25 0.21 0.20 0.19 0.15
## Cumulative Proportion 0.25 0.46 0.66 0.85 1.00
## 
##  With factor correlations of 
##       MR2   MR1   MR3   MR5   MR4
## MR2  1.00 -0.21 -0.19 -0.04 -0.01
## MR1 -0.21  1.00  0.23  0.33  0.17
## MR3 -0.19  0.23  1.00  0.20  0.19
## MR5 -0.04  0.33  0.20  1.00  0.19
## MR4 -0.01  0.17  0.19  0.19  1.00
## 
## Mean item complexity =  1.5
## Test of the hypothesis that 5 factors are sufficient.
## 
## The degrees of freedom for the null model are  300  and the objective function was  7.23 with Chi Square of  20163.79
## The degrees of freedom for the model are 185  and the objective function was  0.65 
## 
## The root mean square of the residuals (RMSR) is  0.03 
## The df corrected root mean square of the residuals is  0.04 
## 
## The harmonic number of observations is  2762 with the empirical chi square  1392.16  with prob &lt;  5.6e-184 
## The total number of observations was  2800  with Likelihood Chi Square =  1808.94  with prob &lt;  4.3e-264 
## 
## Tucker Lewis Index of factoring reliability =  0.867
## RMSEA index =  0.056  and the 90 % confidence intervals are  0.054 0.058
## BIC =  340.53
## Fit based upon off diagonal values = 0.98
## Measures of factor score adequacy             
##                                                    MR2  MR1  MR3  MR5  MR4
## Correlation of (regression) scores with factors   0.92 0.89 0.88 0.88 0.84
## Multiple R square of scores with factors          0.85 0.79 0.77 0.77 0.71
## Minimum correlation of possible factor scores     0.70 0.59 0.54 0.54 0.42</code></pre>
</div>
<div id="using-gt-to-build-a-beautiful-efa-results-table" class="section level2">
<h2>Using gt() to build a beautiful EFA results table</h2>
<p>Below is the <code>fa_table</code> function that takes the factor analysis object from <code>psych::fa()</code> as its input and returns a clean table. Some code elements were adapted from <code>sjPlot::fa_tab()</code> and <a href="https://www.anthonyschmidt.co/post/2020-09-27-efa-tables-in-r/">a blogpost by Anthony Schmidt</a>.</p>
<pre class="r"><code>fa_table &lt;- function(x, varlabels = NULL, title = &quot;Factor analysis results&quot;, diffuse = .10, small = .30, cross = .20, sort = TRUE) {
  #get sorted loadings
  require(dplyr)
  require(purrr)
  require(tibble)
  require(gt)
  if(sort == TRUE) {
    x &lt;- psych::fa.sort(x)
  }
  if(!is.null(varlabels)) {
    if(length(varlabels) != nrow(x$loadings)) { warning(&quot;Number of variable labels and number of variables are unequal. Check your input!&quot;,
                                                        call. = FALSE) }
    if(sort == TRUE) {
      varlabels &lt;- varlabels[x$order]
      }
  }
  if(is.null(varlabels)) {varlabels &lt;- rownames(x$loadings)}

  loadings &lt;- data.frame(unclass(x$loadings))
  
  #make nice names
  factornamer &lt;- function(nfactors) {
    paste0(&quot;Factor_&quot;, 1:nfactors)}
  
  nfactors &lt;- ncol(loadings)
  fnames &lt;- factornamer(nfactors)
  names(loadings) &lt;- fnames
  
  # prepare locations
  factorindex &lt;- apply(loadings, 1, function(x) which.max(abs(x)))
  
  # adapted from from sjplot: getremovableitems
  getRemovableItems &lt;- function(dataframe, fctr.load.tlrn = diffuse) {
    # clear vector
    removers &lt;- vector(length = nrow(dataframe))
    # iterate each row of the data frame. each row represents
    # one item with its factor loadings
    for (i in seq_along(removers)) {
      # get factor loadings for each item
      rowval &lt;- as.numeric(abs(dataframe[i, ]))
      # retrieve highest loading
      maxload &lt;- max(rowval)
      # retrieve 2. highest loading
      max2load &lt;- sort(rowval, TRUE)[2]
      # check difference between both
      if (abs(maxload - max2load) &lt; fctr.load.tlrn) {
        # if difference is below the tolerance,
        # remeber row-ID so we can remove that items
        # for further PCA with updated data frame
        removers[i] &lt;- TRUE
      }
    }
    # return a vector with index numbers indicating which items
    # have unclear loadings
    return(removers)
  }
 if(nfactors &gt; 1) {
   removable &lt;- getRemovableItems(loadings)
   cross_loadings &lt;- purrr::map2(fnames, seq_along(fnames), function(f, i) {
     (abs(loadings[,f] &gt; cross)) &amp; (factorindex != i) 
   })
 }

  small_loadings &lt;- purrr::map(fnames, function(f) {
    abs(loadings[,f]) &lt; small
  })
  
  ind_table &lt;- dplyr::tibble(varlabels, loadings) %&gt;%
    dplyr::rename(Indicator = varlabels) %&gt;% 
    dplyr::mutate(Communality = x$communality, Uniqueness = x$uniquenesses, Complexity = x$complexity) %&gt;% 
    dplyr::mutate(across(starts_with(&quot;Factor&quot;), round, 3))  %&gt;%
    dplyr::mutate(across(c(Communality, Uniqueness, Complexity), round, 2))
                    
  
  ind_table &lt;- ind_table %&gt;% gt(rowname_col = &quot;Indicator&quot;) %&gt;% tab_header(title = title)
  # mark small loadiongs
  for(f in seq_along(fnames)) {
    ind_table &lt;- ind_table %&gt;%  tab_style(style = cell_text(color = &quot;#D3D3D3&quot;, style = &quot;italic&quot;),
                             locations = cells_body(columns = fnames[f], rows = small_loadings[[f]]))
  }
  # mark cross loadings
  
  if (nfactors &gt; 1) {
    for (f in seq_along(fnames)) {
      ind_table &lt;-
        ind_table %&gt;%  tab_style(
          style = cell_text(style = &quot;italic&quot;),
          locations = cells_body(columns = fnames[f], rows = cross_loadings[[f]])
        )
    }
    # mark non-assignable indicators
    ind_table &lt;-
      ind_table %&gt;%  tab_style(style = cell_fill(color = &quot;#D93B3B&quot;),
                               locations = cells_body(rows = removable))
  }
  
  # adapted from https://www.anthonyschmidt.co/post/2020-09-27-efa-tables-in-r/
  Vaccounted &lt;- x[[&quot;Vaccounted&quot;]]
  colnames(Vaccounted) &lt;- fnames 
  if (nfactors &gt; 1) {
  Phi &lt;- x[[&quot;Phi&quot;]]
  rownames(Phi) &lt;- fnames
  colnames(Phi) &lt;- fnames
  f_table &lt;- rbind(Vaccounted, Phi) %&gt;%
    as.data.frame() %&gt;% 
    rownames_to_column(&quot;Property&quot;) %&gt;%
    mutate(across(where(is.numeric), round, 3)) %&gt;%
    gt() %&gt;% tab_header(title = &quot;Eigenvalues, Variance Explained, and Factor Correlations for Rotated Factor Solution&quot;)
  }
  else if(nfactors == 1) {
    f_table &lt;- rbind(Vaccounted) %&gt;%
      as.data.frame() %&gt;% 
      rownames_to_column(&quot;Property&quot;) %&gt;%
      mutate(across(where(is.numeric), round, 3)) %&gt;%
      gt() %&gt;% tab_header(title = &quot;Eigenvalues, Variance Explained, and Factor Correlations for Rotated Factor Solution&quot;)
  }

  return(list(&quot;ind_table&quot; = ind_table, &quot;f_table&quot; = f_table))
  
}</code></pre>
<p>We run the function on the results:</p>
<pre class="r"><code>tables &lt;- fa_table(res)
tables$ind_table</code></pre>
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#sgxmqjddtv .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#sgxmqjddtv .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#sgxmqjddtv .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#sgxmqjddtv .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#sgxmqjddtv .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#sgxmqjddtv .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#sgxmqjddtv .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#sgxmqjddtv .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#sgxmqjddtv .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#sgxmqjddtv .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#sgxmqjddtv .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#sgxmqjddtv .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#sgxmqjddtv .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#sgxmqjddtv .gt_from_md > :first-child {
  margin-top: 0;
}

#sgxmqjddtv .gt_from_md > :last-child {
  margin-bottom: 0;
}

#sgxmqjddtv .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#sgxmqjddtv .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#sgxmqjddtv .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#sgxmqjddtv .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#sgxmqjddtv .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#sgxmqjddtv .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#sgxmqjddtv .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#sgxmqjddtv .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#sgxmqjddtv .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#sgxmqjddtv .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#sgxmqjddtv .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#sgxmqjddtv .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#sgxmqjddtv .gt_left {
  text-align: left;
}

#sgxmqjddtv .gt_center {
  text-align: center;
}

#sgxmqjddtv .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#sgxmqjddtv .gt_font_normal {
  font-weight: normal;
}

#sgxmqjddtv .gt_font_bold {
  font-weight: bold;
}

#sgxmqjddtv .gt_font_italic {
  font-style: italic;
}

#sgxmqjddtv .gt_super {
  font-size: 65%;
}

#sgxmqjddtv .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="sgxmqjddtv" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="9" class="gt_heading gt_title gt_font_normal gt_bottom_border" style>Factor analysis results</th>
    </tr>
    
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1"></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">Factor_1</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">Factor_2</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">Factor_3</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">Factor_4</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">Factor_5</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">Communality</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">Uniqueness</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">Complexity</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left gt_stub">N1</td>
<td class="gt_row gt_right">0.815</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.103</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.004</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.111</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.047</td>
<td class="gt_row gt_right">0.65</td>
<td class="gt_row gt_right">0.35</td>
<td class="gt_row gt_right">1.08</td></tr>
    <tr><td class="gt_row gt_left gt_stub">N2</td>
<td class="gt_row gt_right">0.777</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.040</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.011</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.094</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.015</td>
<td class="gt_row gt_right">0.60</td>
<td class="gt_row gt_right">0.40</td>
<td class="gt_row gt_right">1.04</td></tr>
    <tr><td class="gt_row gt_left gt_stub">N3</td>
<td class="gt_row gt_right">0.706</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.100</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.035</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.079</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.023</td>
<td class="gt_row gt_right">0.55</td>
<td class="gt_row gt_right">0.45</td>
<td class="gt_row gt_right">1.07</td></tr>
    <tr><td class="gt_row gt_left gt_stub">N5</td>
<td class="gt_row gt_right">0.486</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.202</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.004</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.207</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.150</td>
<td class="gt_row gt_right">0.35</td>
<td class="gt_row gt_right">0.65</td>
<td class="gt_row gt_right">1.96</td></tr>
    <tr><td class="gt_row gt_left gt_stub">N4</td>
<td class="gt_row gt_right" style="background-color: #D93B3B;">0.474</td>
<td class="gt_row gt_right" style="background-color: #D93B3B;">-0.386</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic; background-color: #D93B3B;">-0.135</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic; background-color: #D93B3B;">0.095</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic; background-color: #D93B3B;">0.080</td>
<td class="gt_row gt_right" style="background-color: #D93B3B;">0.49</td>
<td class="gt_row gt_right" style="background-color: #D93B3B;">0.51</td>
<td class="gt_row gt_right" style="background-color: #D93B3B;">2.27</td></tr>
    <tr><td class="gt_row gt_left gt_stub">E2</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.099</td>
<td class="gt_row gt_right">-0.676</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.016</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.048</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.058</td>
<td class="gt_row gt_right">0.54</td>
<td class="gt_row gt_right">0.46</td>
<td class="gt_row gt_right">1.07</td></tr>
    <tr><td class="gt_row gt_left gt_stub">E4</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.014</td>
<td class="gt_row gt_right">0.591</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.024</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.287</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.077</td>
<td class="gt_row gt_right">0.53</td>
<td class="gt_row gt_right">0.47</td>
<td class="gt_row gt_right">1.49</td></tr>
    <tr><td class="gt_row gt_left gt_stub">E1</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.059</td>
<td class="gt_row gt_right">-0.557</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.106</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.083</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.103</td>
<td class="gt_row gt_right">0.35</td>
<td class="gt_row gt_right">0.65</td>
<td class="gt_row gt_right">1.21</td></tr>
    <tr><td class="gt_row gt_left gt_stub">E5</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.152</td>
<td class="gt_row gt_right">0.421</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.271</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.052</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.206</td>
<td class="gt_row gt_right">0.40</td>
<td class="gt_row gt_right">0.60</td>
<td class="gt_row gt_right">2.60</td></tr>
    <tr><td class="gt_row gt_left gt_stub">E3</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.083</td>
<td class="gt_row gt_right">0.418</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.001</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.246</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.283</td>
<td class="gt_row gt_right">0.44</td>
<td class="gt_row gt_right">0.56</td>
<td class="gt_row gt_right">2.55</td></tr>
    <tr><td class="gt_row gt_left gt_stub">C2</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.149</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.085</td>
<td class="gt_row gt_right">0.666</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.081</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.039</td>
<td class="gt_row gt_right">0.45</td>
<td class="gt_row gt_right">0.55</td>
<td class="gt_row gt_right">1.17</td></tr>
    <tr><td class="gt_row gt_left gt_stub">C4</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.174</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.002</td>
<td class="gt_row gt_right">-0.614</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.040</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.048</td>
<td class="gt_row gt_right">0.45</td>
<td class="gt_row gt_right">0.55</td>
<td class="gt_row gt_right">1.18</td></tr>
    <tr><td class="gt_row gt_left gt_stub">C3</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.034</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.061</td>
<td class="gt_row gt_right">0.567</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.092</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.068</td>
<td class="gt_row gt_right">0.32</td>
<td class="gt_row gt_right">0.68</td>
<td class="gt_row gt_right">1.11</td></tr>
    <tr><td class="gt_row gt_left gt_stub">C5</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.189</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.142</td>
<td class="gt_row gt_right">-0.553</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.018</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.092</td>
<td class="gt_row gt_right">0.43</td>
<td class="gt_row gt_right">0.57</td>
<td class="gt_row gt_right">1.44</td></tr>
    <tr><td class="gt_row gt_left gt_stub">C1</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.069</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.027</td>
<td class="gt_row gt_right">0.546</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.023</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.148</td>
<td class="gt_row gt_right">0.33</td>
<td class="gt_row gt_right">0.67</td>
<td class="gt_row gt_right">1.19</td></tr>
    <tr><td class="gt_row gt_left gt_stub">A3</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.029</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.116</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.025</td>
<td class="gt_row gt_right">0.660</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.031</td>
<td class="gt_row gt_right">0.52</td>
<td class="gt_row gt_right">0.48</td>
<td class="gt_row gt_right">1.07</td></tr>
    <tr><td class="gt_row gt_left gt_stub">A2</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.023</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.002</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.077</td>
<td class="gt_row gt_right">0.640</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.032</td>
<td class="gt_row gt_right">0.45</td>
<td class="gt_row gt_right">0.55</td>
<td class="gt_row gt_right">1.04</td></tr>
    <tr><td class="gt_row gt_left gt_stub">A5</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.112</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.233</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.006</td>
<td class="gt_row gt_right">0.532</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.044</td>
<td class="gt_row gt_right">0.46</td>
<td class="gt_row gt_right">0.54</td>
<td class="gt_row gt_right">1.49</td></tr>
    <tr><td class="gt_row gt_left gt_stub">A4</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.057</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.064</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.193</td>
<td class="gt_row gt_right">0.433</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.148</td>
<td class="gt_row gt_right">0.28</td>
<td class="gt_row gt_right">0.72</td>
<td class="gt_row gt_right">1.74</td></tr>
    <tr><td class="gt_row gt_left gt_stub">A1</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.213</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.166</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.067</td>
<td class="gt_row gt_right">-0.414</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.058</td>
<td class="gt_row gt_right">0.19</td>
<td class="gt_row gt_right">0.81</td>
<td class="gt_row gt_right">1.97</td></tr>
    <tr><td class="gt_row gt_left gt_stub">O3</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.031</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.152</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.017</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.083</td>
<td class="gt_row gt_right">0.609</td>
<td class="gt_row gt_right">0.46</td>
<td class="gt_row gt_right">0.54</td>
<td class="gt_row gt_right">1.17</td></tr>
    <tr><td class="gt_row gt_left gt_stub">O5</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.132</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.098</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.025</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.043</td>
<td class="gt_row gt_right">-0.542</td>
<td class="gt_row gt_right">0.30</td>
<td class="gt_row gt_right">0.70</td>
<td class="gt_row gt_right">1.21</td></tr>
    <tr><td class="gt_row gt_left gt_stub">O1</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.018</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.103</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.073</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.015</td>
<td class="gt_row gt_right">0.508</td>
<td class="gt_row gt_right">0.31</td>
<td class="gt_row gt_right">0.69</td>
<td class="gt_row gt_right">1.13</td></tr>
    <tr><td class="gt_row gt_left gt_stub">O2</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.195</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.057</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">-0.078</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic;">0.163</td>
<td class="gt_row gt_right">-0.456</td>
<td class="gt_row gt_right">0.26</td>
<td class="gt_row gt_right">0.74</td>
<td class="gt_row gt_right">1.75</td></tr>
    <tr><td class="gt_row gt_left gt_stub">O4</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic; background-color: #D93B3B;">0.126</td>
<td class="gt_row gt_right" style="background-color: #D93B3B;">-0.323</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic; background-color: #D93B3B;">-0.024</td>
<td class="gt_row gt_right" style="color: #D3D3D3; font-style: italic; background-color: #D93B3B;">0.174</td>
<td class="gt_row gt_right" style="background-color: #D93B3B;">0.371</td>
<td class="gt_row gt_right" style="background-color: #D93B3B;">0.25</td>
<td class="gt_row gt_right" style="background-color: #D93B3B;">0.75</td>
<td class="gt_row gt_right" style="background-color: #D93B3B;">2.69</td></tr>
  </tbody>
  
  
</table></div>
<pre class="r"><code>tables$f_table</code></pre>
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#mzajrlpkej .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#mzajrlpkej .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#mzajrlpkej .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#mzajrlpkej .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#mzajrlpkej .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mzajrlpkej .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#mzajrlpkej .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#mzajrlpkej .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#mzajrlpkej .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#mzajrlpkej .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#mzajrlpkej .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#mzajrlpkej .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#mzajrlpkej .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#mzajrlpkej .gt_from_md > :first-child {
  margin-top: 0;
}

#mzajrlpkej .gt_from_md > :last-child {
  margin-bottom: 0;
}

#mzajrlpkej .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#mzajrlpkej .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#mzajrlpkej .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mzajrlpkej .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#mzajrlpkej .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#mzajrlpkej .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#mzajrlpkej .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#mzajrlpkej .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#mzajrlpkej .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#mzajrlpkej .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#mzajrlpkej .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#mzajrlpkej .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#mzajrlpkej .gt_left {
  text-align: left;
}

#mzajrlpkej .gt_center {
  text-align: center;
}

#mzajrlpkej .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#mzajrlpkej .gt_font_normal {
  font-weight: normal;
}

#mzajrlpkej .gt_font_bold {
  font-weight: bold;
}

#mzajrlpkej .gt_font_italic {
  font-style: italic;
}

#mzajrlpkej .gt_super {
  font-size: 65%;
}

#mzajrlpkej .gt_footnote_marks {
  font-style: italic;
  font-size: 65%;
}
</style>
<div id="mzajrlpkej" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;"><table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="6" class="gt_heading gt_title gt_font_normal gt_bottom_border" style>Eigenvalues, Variance Explained, and Factor Correlations for Rotated Factor Solution</th>
    </tr>
    
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">Property</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">Factor_1</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">Factor_2</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">Factor_3</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">Factor_4</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">Factor_5</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_left">SS loadings</td>
<td class="gt_row gt_right">2.570</td>
<td class="gt_row gt_right">2.199</td>
<td class="gt_row gt_right">2.029</td>
<td class="gt_row gt_right">1.985</td>
<td class="gt_row gt_right">1.586</td></tr>
    <tr><td class="gt_row gt_left">Proportion Var</td>
<td class="gt_row gt_right">0.103</td>
<td class="gt_row gt_right">0.088</td>
<td class="gt_row gt_right">0.081</td>
<td class="gt_row gt_right">0.079</td>
<td class="gt_row gt_right">0.063</td></tr>
    <tr><td class="gt_row gt_left">Cumulative Var</td>
<td class="gt_row gt_right">0.103</td>
<td class="gt_row gt_right">0.191</td>
<td class="gt_row gt_right">0.272</td>
<td class="gt_row gt_right">0.351</td>
<td class="gt_row gt_right">0.415</td></tr>
    <tr><td class="gt_row gt_left">Proportion Explained</td>
<td class="gt_row gt_right">0.248</td>
<td class="gt_row gt_right">0.212</td>
<td class="gt_row gt_right">0.196</td>
<td class="gt_row gt_right">0.191</td>
<td class="gt_row gt_right">0.153</td></tr>
    <tr><td class="gt_row gt_left">Cumulative Proportion</td>
<td class="gt_row gt_right">0.248</td>
<td class="gt_row gt_right">0.460</td>
<td class="gt_row gt_right">0.656</td>
<td class="gt_row gt_right">0.847</td>
<td class="gt_row gt_right">1.000</td></tr>
    <tr><td class="gt_row gt_left">Factor_1</td>
<td class="gt_row gt_right">1.000</td>
<td class="gt_row gt_right">-0.213</td>
<td class="gt_row gt_right">-0.187</td>
<td class="gt_row gt_right">-0.038</td>
<td class="gt_row gt_right">-0.011</td></tr>
    <tr><td class="gt_row gt_left">Factor_2</td>
<td class="gt_row gt_right">-0.213</td>
<td class="gt_row gt_right">1.000</td>
<td class="gt_row gt_right">0.230</td>
<td class="gt_row gt_right">0.329</td>
<td class="gt_row gt_right">0.167</td></tr>
    <tr><td class="gt_row gt_left">Factor_3</td>
<td class="gt_row gt_right">-0.187</td>
<td class="gt_row gt_right">0.230</td>
<td class="gt_row gt_right">1.000</td>
<td class="gt_row gt_right">0.203</td>
<td class="gt_row gt_right">0.195</td></tr>
    <tr><td class="gt_row gt_left">Factor_4</td>
<td class="gt_row gt_right">-0.038</td>
<td class="gt_row gt_right">0.329</td>
<td class="gt_row gt_right">0.203</td>
<td class="gt_row gt_right">1.000</td>
<td class="gt_row gt_right">0.193</td></tr>
    <tr><td class="gt_row gt_left">Factor_5</td>
<td class="gt_row gt_right">-0.011</td>
<td class="gt_row gt_right">0.167</td>
<td class="gt_row gt_right">0.195</td>
<td class="gt_row gt_right">0.193</td>
<td class="gt_row gt_right">1.000</td></tr>
  </tbody>
  
  
</table></div>
<p>The function returns two tables: <code>ind_table</code> for the factor (pattern) loadings, and <code>f_table</code> for aspects at the factor-level. The former table displays the relevant information for each indicator; the use of italics and colors makes it easy to grasp the structure of factor (pattern) loadings. Highlighted in red, we see that N4 and 04 indicators are not represented well in the EFA because they load diffusely over multiple factors.</p>
<p>You can supply custom values for the conditional formatting of the table:</p>
<ul>
<li><code>diffuse</code> specifies the minimum difference an indicator needs to have between factor loadings in order to indicate a clear loading on just one factor, and not diffuse loadings over multiple factors. Diffuse indicators are labelled as red in the table.</li>
<li><code>small</code> specifies when a loading is considered small; these loadings are printed in light gray.</li>
<li><code>cross</code> specifies when a loading is considered to be a cross-loading; these loadings are printed in oblique black.</li>
</ul>
<p>The <code>fa_table()</code> function is a work in progress and the latest version can be found at: <a href="https://github.com/franciscowilhelm/r-collection/blob/master/fa_table.R" class="uri">https://github.com/franciscowilhelm/r-collection/blob/master/fa_table.R</a></p>
<p>Import it to R via:
<code>source("https://raw.githubusercontent.com/franciscowilhelm/r-collection/master/fa_table.R")</code></p>
</div>
