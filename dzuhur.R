library(rtweet)
library(mongolite)

connection_string <- Sys.getenv("MONGODB_CONNECT")
jadwal_collection <- mongo(collection = "jadwal", 
                           db = "sample_dataset_R", 
                           url = connection_string, 
                           verbose = TRUE)

# POST TWITTER
upload <- jadwal_collection$find(sort='{"_id":-1}', limit=1)
hashtag <- c("hayusholat","kuysholat","yukshalat","prayers","prayertime")
samp_word <- sample(hashtag, 1)

post  <- paste0(
  "🕋 Akan tiba waktu Dzuhur untuk Kota Bogor dan sekitarnya pada pukul ", upload$Dzuhur, "\n",
  "\n\n",
  paste0("#", samp_word))

twitter_token <- rtweet::create_token(
  app = "ShalatBot",
  consumer_key = Sys.getenv("TWITTER_CONSUMER_API_KEY"), 
  consumer_secret = Sys.getenv("TWITTER_CONSUMER_API_SECRET"),
  access_token = Sys.getenv("TWITTER_ACCESS_TOKEN"),
  access_secret = Sys.getenv("TWITTER_ACCESS_TOKEN_SECRET")
)

rtweet::post_tweet(
  status = post,
  token = twitter_token
)
