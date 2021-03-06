#' Dictionary Wrapper
#' @description
#' @param text a character vector of texts.
#' @param dict
#' @param binary
#' @param ...
#' @return
#' @keywords internal

dictWrap<-function (text, dict = liwc.lists, binary = F, ...) {
  CTB <- as.matrix(array(0, c(length(text), length(dict))))
  WC <- qdap::word_count(text)
  wc1 <- (!is.na(WC))
  dic.try<-quanteda::dfm(text[wc1], dictionary = dict,verbose = F, ...)
  if(length(dic.try)==0){
    emptyct<-matrix(0,nrow=length(text),ncol=length(dict))
    colnames(emptyct)<-substr(names(dict), 0, unlist(gregexpr("@", names(dict))) - 1)
    return(emptyct)
  }else{
    CTD <- as.matrix(dic.try)[, 1:length(dict)]
    if (is.null(nrow(CTD)))
      CTD <- CTD/WC[wc1]
    if (!is.null(nrow(CTD)))
      CTD <- apply(CTD, 2, function(x) x/WC[wc1])
    CTB[wc1, ] <- CTD
    colnames(CTB) <- substr(names(dict), 0, unlist(gregexpr("@", names(dict))) - 1)
    if (binary)
      CTB <- 1 * (CTB == 0)
    return(CTB)
  }
}
################################################################


# ################################################################
# hedge_list<-readLines("modeldata/hedges.txt")
# positive_list<-readLines("modeldata/positive-words.txt")
# negative_list<-readLines("modeldata/negative-words.txt")
# other.lists<-quanteda::dictionary(file="modeldata/LQ.dic")
# ################################################################
# polite_dicts<-other.lists[c("ipron@ImpersonalPronouns","swear@Swear","negate@Negations")]
# polite_dicts[["pause@FilledPause"]]<-c("er","sigh","hm*","uh*","um*")
# polite_dicts[["intitle@InformalTitle"]]<-c("dude*", "bro*", "boss", "bud", "buddy", "champ", "man", "guy*", "guy", "brotha", "sista", "son", "sonny", "chief")
# polite_dicts[["title@FormalTitle"]]<-c("sir", "ma'am", "maam", "mister", "mr*", "ms*", "madam", "miss", "gentleman", "lady")
# ################################################################
#
# devtools::use_data(hedge_list,
#                    positive_list,
#                    negative_list,
#                    polite_dicts,
#                    internal = TRUE)
