library(rvest)
library(mongolite)

# List of shalat sites
# https://www.islamicfinder.org/world/indonesia/

url <- 'https://www.islamicfinder.org/world/indonesia/1648473/bogor-prayer-times/?language=id'
page <- read_html(url)

# waktu sholat kota bogor

teks <- page %>% 
  html_nodes('span') %>% 
  html_text()
nama <- c(teks[27],teks[31],teks[33],teks[35],teks[37])
waktu <- cbind.data.frame(teks[28],teks[32],teks[34],teks[36],teks[38])
colnames(waktu) <- nama
waktu

# koneksi ke mongoDB

connection_string = Sys.getenv("MONGODB_CONNECT")
jadwal_collection <- mongo(collection = "jadwal", # Creating collection
                           db = "sample_dataset_R", # Creating DataBase
                           url = connection_string, 
                           verbose = TRUE)

# input data ke mongoDB

jadwal_collection$insert(waktu)
