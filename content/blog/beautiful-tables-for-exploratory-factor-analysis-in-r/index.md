---
title: Beautiful Tables for Exploratory Factor Analysis in R
author: Francisco Wilhelm
date: '2021-02-22'
format: hugo-md
slug: exploratory-factor-analysis-table
categories: []
tags:
  - R
  - statistics
---


The `psych` package for R provides great utilities for exploratory factor analysis (EFA). However, the way `psych` displays the results does not take advantage of visual cues to make grasping the factor solutions easier, nor is it straightforward to display the results in a way that can be shared easily with others.
Several solutions to the problem have been proposed, such as the LaTeX-based [`psych::df2latex()`](http://personality-project.org/r/psych/help/df2latex.html) or an implementation in the sjPlot package `sjPlot::fa_tab()`. Because these solutions have some drawbacks, here's another take on the issue.

The solution I present here is consistent with the tidyverse and builds on the highly flexible and powerful `gt` package to provide beautiful and highly customizable tables that can be used in R Markdown approaches.

## Factor Analysis Example

We need several packages to get started:

``` r
library(psych)
library(tidyverse)
library(gt)
```

As an example we use the IPIP Big Five Inventory from the `psych` package. First we run a factor analysis; I will not go into details here as these are discussed in-depth in the psych package and EFA best practice papers.

``` r
res <- fa(psychTools::bfi[1:25],5)
```

The standard way to display the EFA results are not very clean or legible inside a markdown output.

``` r
print(res)
```

    Factor Analysis using method =  minres
    Call: fa(r = psychTools::bfi[1:25], nfactors = 5)
    Standardized loadings (pattern matrix) based upon correlation matrix
         MR2   MR1   MR3   MR5   MR4   h2   u2 com
    A1  0.21  0.17  0.07 -0.41 -0.06 0.19 0.81 2.0
    A2 -0.02  0.00  0.08  0.64  0.03 0.45 0.55 1.0
    A3 -0.03  0.12  0.02  0.66  0.03 0.52 0.48 1.1
    A4 -0.06  0.06  0.19  0.43 -0.15 0.28 0.72 1.7
    A5 -0.11  0.23  0.01  0.53  0.04 0.46 0.54 1.5
    C1  0.07 -0.03  0.55 -0.02  0.15 0.33 0.67 1.2
    C2  0.15 -0.09  0.67  0.08  0.04 0.45 0.55 1.2
    C3  0.03 -0.06  0.57  0.09 -0.07 0.32 0.68 1.1
    C4  0.17  0.00 -0.61  0.04 -0.05 0.45 0.55 1.2
    C5  0.19 -0.14 -0.55  0.02  0.09 0.43 0.57 1.4
    E1 -0.06 -0.56  0.11 -0.08 -0.10 0.35 0.65 1.2
    E2  0.10 -0.68 -0.02 -0.05 -0.06 0.54 0.46 1.1
    E3  0.08  0.42  0.00  0.25  0.28 0.44 0.56 2.6
    E4  0.01  0.59  0.02  0.29 -0.08 0.53 0.47 1.5
    E5  0.15  0.42  0.27  0.05  0.21 0.40 0.60 2.6
    N1  0.81  0.10  0.00 -0.11 -0.05 0.65 0.35 1.1
    N2  0.78  0.04  0.01 -0.09  0.01 0.60 0.40 1.0
    N3  0.71 -0.10 -0.04  0.08  0.02 0.55 0.45 1.1
    N4  0.47 -0.39 -0.14  0.09  0.08 0.49 0.51 2.3
    N5  0.49 -0.20  0.00  0.21 -0.15 0.35 0.65 2.0
    O1  0.02  0.10  0.07  0.02  0.51 0.31 0.69 1.1
    O2  0.19  0.06 -0.08  0.16 -0.46 0.26 0.74 1.7
    O3  0.03  0.15  0.02  0.08  0.61 0.46 0.54 1.2
    O4  0.13 -0.32 -0.02  0.17  0.37 0.25 0.75 2.7
    O5  0.13  0.10 -0.03  0.04 -0.54 0.30 0.70 1.2

                           MR2  MR1  MR3  MR5  MR4
    SS loadings           2.57 2.20 2.03 1.99 1.59
    Proportion Var        0.10 0.09 0.08 0.08 0.06
    Cumulative Var        0.10 0.19 0.27 0.35 0.41
    Proportion Explained  0.25 0.21 0.20 0.19 0.15
    Cumulative Proportion 0.25 0.46 0.66 0.85 1.00

     With factor correlations of 
          MR2   MR1   MR3   MR5   MR4
    MR2  1.00 -0.21 -0.19 -0.04 -0.01
    MR1 -0.21  1.00  0.23  0.33  0.17
    MR3 -0.19  0.23  1.00  0.20  0.19
    MR5 -0.04  0.33  0.20  1.00  0.19
    MR4 -0.01  0.17  0.19  0.19  1.00

    Mean item complexity =  1.5
    Test of the hypothesis that 5 factors are sufficient.

    df null model =  300  with the objective function =  7.23 with Chi Square =  20163.79
    df of  the model are 185  and the objective function was  0.65 

    The root mean square of the residuals (RMSR) is  0.03 
    The df corrected root mean square of the residuals is  0.04 

    The harmonic n.obs is  2762 with the empirical chi square  696.08  with prob <  2.7e-60 
    The total n.obs was  2800  with Likelihood Chi Square =  1808.94  with prob <  4.3e-264 

    Tucker Lewis Index of factoring reliability =  0.867
    RMSEA index =  0.056  and the 90 % confidence intervals are  0.054 0.058
    BIC =  340.53
    Fit based upon off diagonal values = 0.98
    Measures of factor score adequacy             
                                                       MR2  MR1  MR3  MR5  MR4
    Correlation of (regression) scores with factors   0.91 0.82 0.84 0.82 0.81
    Multiple R square of scores with factors          0.83 0.67 0.70 0.67 0.66
    Minimum correlation of possible factor scores     0.65 0.34 0.41 0.34 0.31

## Using gt() to build a beautiful EFA results table

Below is the `fa_table` function that takes the factor analysis object from `psych::fa()` as its input and returns a clean table. Some code elements were adapted from `sjPlot::fa_tab()` and [a blogpost by Anthony Schmidt](https://www.anthonyschmidt.co/post/2020-09-27-efa-tables-in-r/).

``` r
fa_table <- function(x, varlabels = NULL, title = "Factor analysis results", diffuse = .10, small = .30, cross = .20, sort = TRUE) {
  #get sorted loadings
  require(dplyr)
  require(purrr)
  require(tibble)
  require(gt)
  if(sort == TRUE) {
    x <- psych::fa.sort(x)
  }
  if(!is.null(varlabels)) {
    if(length(varlabels) != nrow(x$loadings)) { warning("Number of variable labels and number of variables are unequal. Check your input!",
                                                        call. = FALSE) }
    if(sort == TRUE) {
      varlabels <- varlabels[x$order]
      }
  }
  if(is.null(varlabels)) {varlabels <- rownames(x$loadings)}

  loadings <- data.frame(unclass(x$loadings))

  #make nice names
  factornamer <- function(nfactors) {
    paste0("Factor_", 1:nfactors)}

  nfactors <- ncol(loadings)
  fnames <- factornamer(nfactors)
  names(loadings) <- fnames

  # prepare locations
  factorindex <- apply(loadings, 1, function(x) which.max(abs(x)))

  # adapted from from sjplot: getremovableitems
  getRemovableItems <- function(dataframe, fctr.load.tlrn = diffuse) {
    # clear vector
    removers <- vector(length = nrow(dataframe))
    # iterate each row of the data frame. each row represents
    # one item with its factor loadings
    for (i in seq_along(removers)) {
      # get factor loadings for each item
      rowval <- as.numeric(abs(dataframe[i, ]))
      # retrieve highest loading
      maxload <- max(rowval)
      # retrieve 2. highest loading
      max2load <- sort(rowval, TRUE)[2]
      # check difference between both
      if (abs(maxload - max2load) < fctr.load.tlrn) {
        # if difference is below the tolerance,
        # remeber row-ID so we can remove that items
        # for further PCA with updated data frame
        removers[i] <- TRUE
      }
    }
    # return a vector with index numbers indicating which items
    # have unclear loadings
    return(removers)
  }
 if(nfactors > 1) {
   removable <- getRemovableItems(loadings)
   cross_loadings <- purrr::map2(fnames, seq_along(fnames), function(f, i) {
     (abs(loadings[,f] > cross)) & (factorindex != i)
   })
 }

  small_loadings <- purrr::map(fnames, function(f) {
    abs(loadings[,f]) < small
  })

  ind_table <- dplyr::tibble(varlabels, loadings) %>%
    dplyr::rename(Indicator = varlabels) %>%
    dplyr::mutate(Communality = x$communality, Uniqueness = x$uniquenesses, Complexity = x$complexity) %>%
    dplyr::mutate(across(starts_with("Factor"), round, 3))  %>%
    dplyr::mutate(across(c(Communality, Uniqueness, Complexity), round, 2))


  ind_table <- ind_table %>% gt(rowname_col = "Indicator") %>% tab_header(title = title)
  # mark small loadiongs
  for(f in seq_along(fnames)) {
    ind_table <- ind_table %>%  tab_style(style = cell_text(color = "#D3D3D3", style = "italic"),
                             locations = cells_body(columns = fnames[f], rows = small_loadings[[f]]))
  }
  # mark cross loadings

  if (nfactors > 1) {
    for (f in seq_along(fnames)) {
      ind_table <-
        ind_table %>%  tab_style(
          style = cell_text(style = "italic"),
          locations = cells_body(columns = fnames[f], rows = cross_loadings[[f]])
        )
    }
    # mark non-assignable indicators
    ind_table <-
      ind_table %>%  tab_style(style = cell_fill(color = "#D93B3B"),
                               locations = cells_body(rows = removable))
  }

  # adapted from https://www.anthonyschmidt.co/post/2020-09-27-efa-tables-in-r/
  Vaccounted <- x[["Vaccounted"]]
  colnames(Vaccounted) <- fnames
  if (nfactors > 1) {
  Phi <- x[["Phi"]]
  rownames(Phi) <- fnames
  colnames(Phi) <- fnames
  f_table <- rbind(Vaccounted, Phi) %>%
    as.data.frame() %>%
    rownames_to_column("Property") %>%
    mutate(across(where(is.numeric), round, 3)) %>%
    gt() %>% tab_header(title = "Eigenvalues, Variance Explained, and Factor Correlations for Rotated Factor Solution")
  }
  else if(nfactors == 1) {
    f_table <- rbind(Vaccounted) %>%
      as.data.frame() %>%
      rownames_to_column("Property") %>%
      mutate(across(where(is.numeric), round, 3)) %>%
      gt() %>% tab_header(title = "Eigenvalues, Variance Explained, and Factor Correlations for Rotated Factor Solution")
  }

  return(list("ind_table" = ind_table, "f_table" = f_table))

}
```

We run the function on the results:

``` r
tables <- fa_table(res)
```

    Warning: There was 1 warning in `dplyr::mutate()`.
    ℹ In argument: `across(starts_with("Factor"), round, 3)`.
    Caused by warning:
    ! The `...` argument of `across()` is deprecated as of dplyr 1.1.0.
    Supply arguments directly to `.fns` through an anonymous function instead.

      # Previously
      across(a:b, mean, na.rm = TRUE)

      # Now
      across(a:b, \(x) mean(x, na.rm = TRUE))

``` r
tables$ind_table
```

<div id="vccrcnqpev" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#vccrcnqpev table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#vccrcnqpev thead, #vccrcnqpev tbody, #vccrcnqpev tfoot, #vccrcnqpev tr, #vccrcnqpev td, #vccrcnqpev th {
  border-style: none;
}

#vccrcnqpev p {
  margin: 0;
  padding: 0;
}

#vccrcnqpev .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
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

#vccrcnqpev .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#vccrcnqpev .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#vccrcnqpev .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#vccrcnqpev .gt_heading {
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

#vccrcnqpev .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vccrcnqpev .gt_col_headings {
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

#vccrcnqpev .gt_col_heading {
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

#vccrcnqpev .gt_column_spanner_outer {
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

#vccrcnqpev .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#vccrcnqpev .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#vccrcnqpev .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#vccrcnqpev .gt_spanner_row {
  border-bottom-style: hidden;
}

#vccrcnqpev .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
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
  text-align: left;
}

#vccrcnqpev .gt_empty_group_heading {
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

#vccrcnqpev .gt_from_md > :first-child {
  margin-top: 0;
}

#vccrcnqpev .gt_from_md > :last-child {
  margin-bottom: 0;
}

#vccrcnqpev .gt_row {
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

#vccrcnqpev .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#vccrcnqpev .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#vccrcnqpev .gt_row_group_first td {
  border-top-width: 2px;
}

#vccrcnqpev .gt_row_group_first th {
  border-top-width: 2px;
}

#vccrcnqpev .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vccrcnqpev .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#vccrcnqpev .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#vccrcnqpev .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vccrcnqpev .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#vccrcnqpev .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#vccrcnqpev .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#vccrcnqpev .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#vccrcnqpev .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#vccrcnqpev .gt_footnotes {
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

#vccrcnqpev .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#vccrcnqpev .gt_sourcenotes {
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

#vccrcnqpev .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#vccrcnqpev .gt_left {
  text-align: left;
}

#vccrcnqpev .gt_center {
  text-align: center;
}

#vccrcnqpev .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#vccrcnqpev .gt_font_normal {
  font-weight: normal;
}

#vccrcnqpev .gt_font_bold {
  font-weight: bold;
}

#vccrcnqpev .gt_font_italic {
  font-style: italic;
}

#vccrcnqpev .gt_super {
  font-size: 65%;
}

#vccrcnqpev .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#vccrcnqpev .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#vccrcnqpev .gt_indent_1 {
  text-indent: 5px;
}

#vccrcnqpev .gt_indent_2 {
  text-indent: 10px;
}

#vccrcnqpev .gt_indent_3 {
  text-indent: 15px;
}

#vccrcnqpev .gt_indent_4 {
  text-indent: 20px;
}

#vccrcnqpev .gt_indent_5 {
  text-indent: 25px;
}

#vccrcnqpev .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#vccrcnqpev div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>

| Factor analysis results |  |  |  |  |  |  |  |  |
|----|----|----|----|----|----|----|----|----|
|  | Factor_1 | Factor_2 | Factor_3 | Factor_4 | Factor_5 | Communality | Uniqueness | Complexity |
| N1 | 0.815 | 0.103 | 0.004 | -0.111 | -0.047 | 0.65 | 0.35 | 1.08 |
| N2 | 0.777 | 0.040 | 0.011 | -0.094 | 0.015 | 0.60 | 0.40 | 1.04 |
| N3 | 0.706 | -0.100 | -0.035 | 0.079 | 0.023 | 0.55 | 0.45 | 1.07 |
| N5 | 0.486 | -0.202 | -0.004 | 0.207 | -0.150 | 0.35 | 0.65 | 1.96 |
| N4 | 0.474 | -0.386 | -0.135 | 0.095 | 0.080 | 0.49 | 0.51 | 2.27 |
| E2 | 0.099 | -0.676 | -0.016 | -0.048 | -0.058 | 0.54 | 0.46 | 1.07 |
| E4 | 0.014 | 0.591 | 0.024 | 0.287 | -0.077 | 0.53 | 0.47 | 1.49 |
| E1 | -0.059 | -0.557 | 0.106 | -0.083 | -0.103 | 0.35 | 0.65 | 1.21 |
| E5 | 0.152 | 0.421 | 0.271 | 0.052 | 0.206 | 0.40 | 0.60 | 2.60 |
| E3 | 0.083 | 0.418 | -0.001 | 0.246 | 0.283 | 0.44 | 0.56 | 2.55 |
| C2 | 0.149 | -0.085 | 0.666 | 0.081 | 0.039 | 0.45 | 0.55 | 1.17 |
| C4 | 0.174 | 0.002 | -0.614 | 0.040 | -0.048 | 0.45 | 0.55 | 1.18 |
| C3 | 0.034 | -0.061 | 0.567 | 0.092 | -0.068 | 0.32 | 0.68 | 1.11 |
| C5 | 0.189 | -0.142 | -0.553 | 0.018 | 0.092 | 0.43 | 0.57 | 1.44 |
| C1 | 0.069 | -0.027 | 0.546 | -0.023 | 0.148 | 0.33 | 0.67 | 1.19 |
| A3 | -0.029 | 0.116 | 0.025 | 0.660 | 0.031 | 0.52 | 0.48 | 1.07 |
| A2 | -0.023 | -0.002 | 0.077 | 0.640 | 0.032 | 0.45 | 0.55 | 1.04 |
| A5 | -0.112 | 0.233 | 0.006 | 0.532 | 0.044 | 0.46 | 0.54 | 1.49 |
| A4 | -0.057 | 0.064 | 0.193 | 0.433 | -0.148 | 0.28 | 0.72 | 1.74 |
| A1 | 0.213 | 0.166 | 0.067 | -0.414 | -0.058 | 0.19 | 0.81 | 1.97 |
| O3 | 0.031 | 0.152 | 0.017 | 0.083 | 0.609 | 0.46 | 0.54 | 1.17 |
| O5 | 0.132 | 0.098 | -0.025 | 0.043 | -0.542 | 0.30 | 0.70 | 1.21 |
| O1 | 0.018 | 0.103 | 0.073 | 0.015 | 0.508 | 0.31 | 0.69 | 1.13 |
| O2 | 0.195 | 0.057 | -0.078 | 0.163 | -0.456 | 0.26 | 0.74 | 1.75 |
| O4 | 0.126 | -0.323 | -0.024 | 0.174 | 0.371 | 0.25 | 0.75 | 2.69 |

</div>

``` r
tables$f_table
```

<div id="ndpiztqkke" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#ndpiztqkke table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#ndpiztqkke thead, #ndpiztqkke tbody, #ndpiztqkke tfoot, #ndpiztqkke tr, #ndpiztqkke td, #ndpiztqkke th {
  border-style: none;
}

#ndpiztqkke p {
  margin: 0;
  padding: 0;
}

#ndpiztqkke .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
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

#ndpiztqkke .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#ndpiztqkke .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#ndpiztqkke .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#ndpiztqkke .gt_heading {
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

#ndpiztqkke .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ndpiztqkke .gt_col_headings {
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

#ndpiztqkke .gt_col_heading {
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

#ndpiztqkke .gt_column_spanner_outer {
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

#ndpiztqkke .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ndpiztqkke .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ndpiztqkke .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#ndpiztqkke .gt_spanner_row {
  border-bottom-style: hidden;
}

#ndpiztqkke .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
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
  text-align: left;
}

#ndpiztqkke .gt_empty_group_heading {
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

#ndpiztqkke .gt_from_md > :first-child {
  margin-top: 0;
}

#ndpiztqkke .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ndpiztqkke .gt_row {
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

#ndpiztqkke .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#ndpiztqkke .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#ndpiztqkke .gt_row_group_first td {
  border-top-width: 2px;
}

#ndpiztqkke .gt_row_group_first th {
  border-top-width: 2px;
}

#ndpiztqkke .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ndpiztqkke .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#ndpiztqkke .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#ndpiztqkke .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ndpiztqkke .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ndpiztqkke .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ndpiztqkke .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#ndpiztqkke .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ndpiztqkke .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ndpiztqkke .gt_footnotes {
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

#ndpiztqkke .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ndpiztqkke .gt_sourcenotes {
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

#ndpiztqkke .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#ndpiztqkke .gt_left {
  text-align: left;
}

#ndpiztqkke .gt_center {
  text-align: center;
}

#ndpiztqkke .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ndpiztqkke .gt_font_normal {
  font-weight: normal;
}

#ndpiztqkke .gt_font_bold {
  font-weight: bold;
}

#ndpiztqkke .gt_font_italic {
  font-style: italic;
}

#ndpiztqkke .gt_super {
  font-size: 65%;
}

#ndpiztqkke .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#ndpiztqkke .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#ndpiztqkke .gt_indent_1 {
  text-indent: 5px;
}

#ndpiztqkke .gt_indent_2 {
  text-indent: 10px;
}

#ndpiztqkke .gt_indent_3 {
  text-indent: 15px;
}

#ndpiztqkke .gt_indent_4 {
  text-indent: 20px;
}

#ndpiztqkke .gt_indent_5 {
  text-indent: 25px;
}

#ndpiztqkke .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#ndpiztqkke div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>

| Eigenvalues, Variance Explained, and Factor Correlations for Rotated Factor Solution |  |  |  |  |  |
|----|----|----|----|----|----|
| Property | Factor_1 | Factor_2 | Factor_3 | Factor_4 | Factor_5 |
| SS loadings | 2.570 | 2.199 | 2.029 | 1.985 | 1.586 |
| Proportion Var | 0.103 | 0.088 | 0.081 | 0.079 | 0.063 |
| Cumulative Var | 0.103 | 0.191 | 0.272 | 0.351 | 0.415 |
| Proportion Explained | 0.248 | 0.212 | 0.196 | 0.191 | 0.153 |
| Cumulative Proportion | 0.248 | 0.460 | 0.656 | 0.847 | 1.000 |
| Factor_1 | 1.000 | -0.213 | -0.187 | -0.038 | -0.011 |
| Factor_2 | -0.213 | 1.000 | 0.230 | 0.329 | 0.167 |
| Factor_3 | -0.187 | 0.230 | 1.000 | 0.203 | 0.195 |
| Factor_4 | -0.038 | 0.329 | 0.203 | 1.000 | 0.193 |
| Factor_5 | -0.011 | 0.167 | 0.195 | 0.193 | 1.000 |

</div>

The function returns two tables: `ind_table` for the factor (pattern) loadings, and `f_table` for aspects at the factor-level. The former table displays the relevant information for each indicator; the use of italics and colors makes it easy to grasp the structure of factor (pattern) loadings. Highlighted in red, we see that N4 and 04 indicators are not represented well in the EFA because they load diffusely over multiple factors.

You can supply custom values for the conditional formatting of the table:

-   `diffuse` specifies the minimum difference an indicator needs to have between factor loadings in order to indicate a clear loading on just one factor, and not diffuse loadings over multiple factors. Diffuse indicators are labelled as red in the table.
-   `small` specifies when a loading is considered small; these loadings are printed in light gray.
-   `cross` specifies when a loading is considered to be a cross-loading; these loadings are printed in oblique black.

The `fa_table()` function is a work in progress and the latest version can be found at: https://github.com/franciscowilhelm/r-collection/blob/master/fa_table.R

Import it to R via:
`source("https://raw.githubusercontent.com/franciscowilhelm/r-collection/master/fa_table.R")`
