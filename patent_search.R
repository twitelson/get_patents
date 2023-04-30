#### Patent search for patent number, title, abstract
library(patentsview)

subject <- "PATENT KEYWORDS HERE"

pat_data <- search_pv(query = qry_funs$text_phrase(patent_abstract = c(subject)), per_page = 1000, endpoint = "patents")

pat_df <- as.data.frame(pat_data)

pnumbers <- pat_df$data.patents.patent_number

finalresults <- NULL

for(var in pnumbers){
  abstract <- search_pv(query = qry_funs$eq("patent_number" = var), fields = "patent_abstract" , endpoint = "patents")
  abstract <- as.data.frame(abstract) 
  title <- search_pv(query = qry_funs$eq("patent_number" = var), fields = "patent_title" , endpoint = "patents")
  title <- as.data.frame(title)
  results <- cbind(var, title, abstract)
  finalresults <- rbind(finalresults, results)
  print(var)
}


final <- subset(finalresults, select = c(var, patent_title, patent_abstract))


#make a csv file with results
data_sheet_title <- "NAME HERE"
write.csv(final, data_sheet_title)
