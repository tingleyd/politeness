% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/politenessProjection.R
\name{politenessProjection}
\alias{politenessProjection}
\title{Politeness projection}
\usage{
politenessProjection(df_polite_train, df_covar = NULL,
  df_polite_test = NULL, mnlm_cluster = NULL, ...)
}
\arguments{
\item{df_polite_train}{a data.frame with politeness features as outputed by \code{\link{politeness}} used to train model.}

\item{df_covar}{a data.frame with covariates.}

\item{df_polite_test}{optional data.frame with politeness features as outputed by \code{\link{politeness}} used for model testing.}

\item{mnlm_cluster}{cluster to be used in \code{mnlm}. See  \code{mnlm} and \code{makeCluster}.}

\item{...}{additional parameters to be passed to \code{mnlm}.}
}
\value{
List of df_polite_train and df_polite_test with projection. See details.
}
\description{
Projection of Multinomial Inverse Rextegression estimation for a politness matrix and covariates.
}
\details{
List:
\itemize{
\item train_proj matrix of projection of mlmn using df_covar and df_polite_train.
\item test_proj matrix of projection of mlmn using df_covar and df_polite_train on df_polite_test data.
\item train_coef coeficients of mnlm model using df_covar and df_polite_train.
}
}
\examples{


}
