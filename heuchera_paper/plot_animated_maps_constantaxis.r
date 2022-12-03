library(raster)

table = read.table("~/Desktop/projects/Saxifragales/paleoclimate_curves/zachos_etal_2001_d18O_temperatureEpstein1953.txt", sep = "\t", header = TRUE)
table = na.omit(table)


datafiles <- rev(Sys.glob("*.tif")) # Reverse so oldest is first. This should glob correctly

# Make sure all plotting devices are off -- too many will create errors.
for (i in dev.list()[1]:dev.list()[length(dev.list())]) {
	dev.off()
}
dev.list()

for(i in 1:NROW(datafiles)){
	dev.new(width=4.539062, height=5.356863)
	tempraster <- raster(datafiles[i])
	par(mfrow=c(2,1), mar=c(0,0,2,0), oma=c(0,0,0,0))
	plot(tempraster, main = gsub(".combined.tif", " mya", datafiles[i]), legend.args = list(text = 'Relative\nprobability', side = 3, font = 2, line = 2.5, cex = 1), bty="n", box=FALSE, axes = FALSE, mar = c(0, 0, 0, 0), col=rev( hcl.colors(99, palette = "viridis") ),zlim=c(0,1) )
	#plot(tempraster, main = gsub(".combined.tif", " mya", datafiles[i]), legend.args = list(text = 'Relative\nprobability', side = 3, font = 2, line = 2.5, cex = 1), bty="n", box=FALSE, axes = FALSE, mar = c(0, 0, 0, 0), col=rev( hcl.colors(99, palette = "viridis") ))
	#plot(tempraster, main = gsub(".combined.tif", " mya", datafiles[i]), legend = FALSE, bty="n", box=FALSE, axes = FALSE, mar = c(0, 0, 0, 0))
	par(mar=c(3,3,4,4))
	plot(table$Age.Ma, table$tempC_5pt, main = "Global temperature", xlim = c(3.3, 0), ylim = c(-1.5, 5.5), type = "l", mar = c(10, 10, 10, 10), xlab = "Time", ylab = "Temperature")
	age = as.numeric(gsub(".combined.tif", "", datafiles[i]))
	points(age, approx(table$Age.Ma, table$tempC_5pt, age)$y, col = "red", cex = 2, pch = 19)
	dev.copy(pdf, gsub(".combined.tif", ".plot.pdf", datafiles[i]))
	for (i in dev.list()[1]:dev.list()[length(dev.list())]) {
   		dev.off()
	}
	dev.list()
}




