library(DT)
library(shiny)
library(googleVis)
library(leaflet)
library(wordcloud)
library(shinydashboard)
library(dplyr)
library(fst)
library(data.table)
library(ggplot2)


incen = read.csv("data/ev_incentives.csv")
util= read.csv("data/combined.csv")
evutil = read.csv('data/ev_utility.csv')
load = read.csv('data/load_cycle.csv')
infra = read.csv("data/ev_charging_station_ny.csv")
evnum = read.csv('data/evnum.csv')
evbrand = read.csv('data/evselection.csv')


