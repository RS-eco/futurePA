
library(rnaturalearthhires)
data(countries10)
countries10 <- sf::st_as_sf(countries10)
countries10$ID <- 1:nrow(countries10)
countries <- rasterize(x=countries10, field="ID", y=raster(xmn=-180, xmx=180, ymn=-90, ymx=90, res=0.5))
plot(countries)
countries <- as.data.frame(rasterToPoints(countries))
colnames(countries) <- c("x", "y", "ID")
countries <- dplyr::left_join(countries, countries10, by="ID")
countries <- dplyr::select(countries, c(x,y, ADM0_A3, NAME, NAME_LONG))

# Save to file
readr::write_csv(countries, "data/countries_05deg.csv.xz")

# Load realm data
library(geodat)
data(zoorealms)
names_realm <- zoorealms$Realm

library(raster)
realms <- rasterize(zoorealms, raster(xmn=-180, xmx=180, 
                                      ymn=-90, ymx=90, 
                                      res=0.5))
realms <- as.data.frame(rasterToPoints(realms))
colnames(realms) <- c("x", "y", "realm")
realms$realm <- factor(realms$realm, labels=names_realm)

# Save to file
readr::write_csv(realms, "data/realms_05deg.csv.xz")


data(biomes)
names_biomes <- c("Tropical and subtropical moist broadleaf forests",
                  "Tropical and subtropical dry broadlef forests",
                  "Tropical and subtropical coniferous forests",
                  "Temperate broadlef and mixed forests", 
                  "Temperate coniferous forests",
                  "Boreal forests/Taiga", 
                  "Tropical and subtropical grasslands, savannas and shrublands",
                  "Temperate grasslands, savannas and shrublands",
                  "Flooded grasslands and savannas",
                  "Montane grasslands and shrublands",
                  "Tundra", "Mediterranean forests, woodlands and scrub",
                  "Deserts and xeric shrublands", "Mangroves", NA, NA)
biomes <- rasterize(biomes, raster(xmn=-180, xmx=180, 
                                   ymn=-90, ymx=90, 
                                   res=0.5)) 
biomes <- as.data.frame(rasterToPoints(biomes))
colnames(biomes) <- c("x", "y", "biome")
biomes$biome <- factor(biomes$biome, labels=names_biomes)

# Save to file
readr::write_csv(biomes, "data/biomes_05deg.csv.xz")

# Load continent data
library(ggmap2)
data(continents)
names_con <- unique(continents$CONTINENT)

# Turn into raster with 0.5deg resolution
continents <- rasterize(continents, raster(xmn=-180, xmx=180, 
                                           ymn=-90, ymx=90, res=0.5))
continents <- as.data.frame(rasterToPoints(continents))
colnames(continents) <- c("x", "y", "continent")
continents$continent <- factor(continents$continent, labels=names_con)

# Save to file
readr::write_csv(continents, "data/continents_05deg.csv.xz")
  