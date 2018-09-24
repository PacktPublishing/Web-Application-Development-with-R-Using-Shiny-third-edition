
### Tidy code

library(tidyr)

medals = data.frame(country = c("Norway", "Germany", "Canada"),
                    gold = c(14, 14, 11),
                    silver = c(14, 10, 8),
                    bronze = c(11, 7, 10)
)

gather(medals, key = Type, value = Medals, -country)

### gapminder

library(tidyverse)
library(gapminder)

groupedData = gapminder %>%
  filter(year > 1960) %>%
  group_by(continent, year) %>%
  summarise(meanLife = mean(lifeExp))

