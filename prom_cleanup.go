package main

import (
	"context"
	"log"
	"os"
	"os/signal"
	"regexp"
	"time"

	"github.com/alecthomas/repr"

	"github.com/prometheus/client_golang/api"
	promv1 "github.com/prometheus/client_golang/api/prometheus/v1"
)

func main() {
	ctx, cancel := signal.NotifyContext(context.Background(), os.Interrupt, os.Kill)
	defer cancel()

	ac, err := api.NewClient(api.Config{Address: "http://192.168.0.102:9090"})
	if err != nil {
		log.Fatal(err)
	}
	pc := promv1.NewAPI(ac)

	prefixMatch := regexp.MustCompile("^(prometheus|scrape|process|promhttp|go|net|node|ALERTS|apt)_.+")

	now := time.Now()
	labels, _, err := pc.LabelValues(ctx, "__name__", nil, now.AddDate(0, -3, 0), now)
	if err != nil {
		log.Fatal(err)
	}

	repr.Println(labels)
	return

	for _, k := range labels {
		if prefixMatch.MatchString(string(k)) || k == "up" {
			log.Println("Deleting", string(k))
			if err := pc.DeleteSeries(ctx, []string{string(k)}, now.AddDate(0, -3, 0), now.AddDate(0, 0, -14)); err != nil {
				log.Fatalln(err)
			}
		}
	}
	if err := pc.CleanTombstones(ctx); err != nil {
		log.Println(err)
	}
	log.Println("Done")
}
