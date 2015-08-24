argv <- commandArgs(trailingOnly = TRUE)
print(argv)

library(bibtex)

src <- readLines(argv[1])
bib <- read.bib("MLDept.bib")
bib.used <- logical(length(bib))
names(bib.used) <- names(bib)


m <- regexec("\\[@([a-zA-Z0-9]*)\\]", src)
tags <- regmatches(src, m)
while (sum(sapply(tags, length) > 0) > 0) {
  dst <- src
  for(i in which(sapply(tags, length) > 0)) {
    name <- tags[[i]][2]
    bib.used[name] <- TRUE
    dst[i] <- sub(tags[[i]][1], cite(name, bib), src[i], fixed = TRUE)
  }
  src <- dst
  m <- regexec("\\[@([a-zA-Z0-9]*)\\]", src)
  tags <- regmatches(src, m)
}

reference <- c("# 參考文獻", sapply(bib[bib.used], format))
dst <- c(dst, paste(reference, collapse = "\n\n"))

write(dst, argv[2])
