data = read.csv("2017-2018 data.csv")

sum(is.na(data[,1]))

#doesnt matter if building name is na

#remove all na data for gross floor area and address, cannot do meaningful comparison without it.

sum(is.na(data$grossfloorarea))


data = data[!is.na(data$grossfloorarea), ] # remove na GFA

sum(is.na(data$buildingaddress))

###

data2 = read.csv("2018-2019 data.csv")

data2 = data2[data2$grossfloorarea != "N/A", ]

### ensure that both data have the same column

class(data)
class(data2)

new_data = data[,-1]
new_data2 = data2[, -1]

names(new_data) == names(new_data2)


library(dplyr)

#full_data = full_join(new_data, new_data2, by = c("buildingaddress", "buildingtype", "greenmarkstatus"))

inner_data = inner_join(new_data, new_data2, by = c("buildingaddress"))


final_data = inner_data[, c(1:9, 18 , 10)]

names(final_data) = c("buildingaddress", "buildingtype",          "greenmarkstatus", "greenmarkrating",
                      "greenmarkyearaward", "buildingsize", "grossfloorarea", "2017energyuseintensity",
                      "2018energyusintensity", "2019energyusintensity", "voluntarydisclosure")


write.csv(final_data, "final_data.csv")
