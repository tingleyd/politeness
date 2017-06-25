################################################################
hedge.list<-readLines("modeldata/hedges.txt")
positive.list<-readLines("modeldata/positive-words.txt")
negative.list<-readLines("modeldata/negative-words.txt")
liwc.lists<-quanteda::dictionary(file="modeldata/LQ.dic")
################################################################
polite.dicts<-liwc.lists[c("ipron@ImpersonalPronouns","swear@Swear","negate@Negations")]
polite.dicts[["pause@FilledPause"]]<-c("er","sigh","hm*","uh*","um*")
polite.dicts[["intitle@InformalTitle"]]<-c("dude*", "bro*", "boss", "bud", "buddy", "champ", "man", "guy*", "guy", "brotha", "sista", "son", "sonny", "chief")
polite.dicts[["title@FormalTitle"]]<-c("sir", "ma'am", "maam", "mister", "mr*", "ms*", "madam", "miss", "gentleman", "lady")
################################################################
LIWCwrap<-function (text, dict = liwc.lists, binary = F, ...) {
  CTB <- as.matrix(array(0, c(length(text), length(dict))))
  WC <- qdap::word_count(text)
  wc1 <- (!is.na(WC))
  CTD <- as.matrix(quanteda::dfm(text[wc1], dictionary = dict,
                                 verbose = F, ...))[, 1:length(dict)]
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
################################################################