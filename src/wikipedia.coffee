# Description:
#   Wikipedia Public API
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot wikipedia such <query> - Gibt die ersten 5 Artikel zurück, die zur Anfrage passen <query>
#   hubot wikipedia zusammenfassung <Artikel> - Gibt eine einzeilige Zusammenfassung zu <Artikel>
#
# Author:
#   MrSaints

WIKI_API_URL = "https://de.wikipedia.org/w/api.php"
WIKI_EN_URL = "https://de.wikipedia.org/wiki"

module.exports = (robot) ->
    robot.respond /wikipedia such (.+)/i, id: "wikipedia.search", (res) ->
        search = res.match[1].trim()
        params =
            action: "opensearch"
            format: "json"
            limit: 5
            search: search

        wikiRequest res, params, (object) ->
            if object[1].length is 0
                res.reply "Keine Artikel gefunden für: \"#{search}\". Versuchen Sie es mit einer anderen Anfrage."
                return

            for article in object[1]
                res.send "#{article}: #{createURL(article)}"

    robot.respond /wikipedia zusammenfassung (.+)/i, id: "wikipedia.summary", (res) ->
        target = res.match[1].trim()
        params =
            action: "query"
            exintro: true
            explaintext: true
            format: "json"
            redirects: true
            prop: "extracts"
            titles: target

        wikiRequest res, params, (object) ->
            for id, article of object.query.pages
                if id is "-1"
                    res.reply "Der angegebene Artikel (\"#{target}\") exisitiert nicht. Versuchen Sie es mit einem anderen."
                    return

                if article.extract is ""
                    summary = "No summary available"
                else
                    summary = article.extract.split(". ")[0..1].join ". "

                res.send "#{article.title}: #{summary}."
                res.reply "Original article: #{createURL(article.title)}"
                return

createURL = (title) ->
    "#{WIKI_EN_URL}/#{encodeURIComponent(title)}"

wikiRequest = (res, params = {}, handler) ->
    res.http(WIKI_API_URL)
        .query(params)
        .get() (err, httpRes, body) ->
            if err
                res.reply "Ein Fehler trat auf während der Anfragebearbeitung: #{err}"
                return robot.logger.error err

            handler JSON.parse(body)