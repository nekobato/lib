express = require "express"
router = express.Router()

# index 
router.get "/", (req, res) ->
  res.render "index",
    title: "Otabooken"
    article:
      id: "article-id"
      title: "article title"
      time: "now"
      body: "article body"
    articles: [
      { id: "id1", title: "article1 title" }
      { id: "id2", title: "article2 title" }
      { id: "id3", title: "article3 title" }
      { id: "id4", title: "article4 title" }
    ]

  return

# article
router.get "/article/(:id)", (req, res) ->
  res.render "index",
    title: "Otabooken"
    article:
      id: "article-id"
      title: "article title"
      time: "now"
      body: "article body"
    articles: [
      { id: "id1", title: "article1 title" }
      { id: "id2", title: "article2 title" }
      { id: "id3", title: "article3 title" }
      { id: "id4", title: "article4 title" }
    ]

  return

# articles
router.get "/articles", (req, res) ->
  res.render "articles",
    articles: [
      { id: "id1", title: "article1 title" }
      { id: "id2", title: "article2 title" }
      { id: "id3", title: "article3 title" }
      { id: "id4", title: "article4 title" }
    ]

  return

# RSS
router.get "/rss", (req, res) ->
  res.render "rss",
    pubDate: "now"
    articles: [
      { id: "id1", title: "article1 title", body: "article body" }
      { id: "id2", title: "article2 title", body: "article body" }
      { id: "id3", title: "article3 title", body: "article body" }
      { id: "id4", title: "article4 title", body: "article body" }
    ]

  return

module.exports = router
