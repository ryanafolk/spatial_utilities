# Dates based on chloroplast

table = read.table("~/Desktop/projects/Saxifragales/paleoclimate_curves/zachos_etal_2001_d18O_temperatureEpstein1953.txt", sep = "\t", header = TRUE)
table = na.omit(table)

dev.new(width=4.539062, height=5.356863)
par(mfrow=c(2,1), mar=c(0,0,2,0), oma=c(0,0,0,0))
par(mar=c(3,3,4,4))
plot(table$Age.Ma, table$tempC_5pt, main = "Global temperature", xlim = c(3.3, 0), ylim = c(-1.5, 5.5), type = "l", mar = c(10, 10, 10, 10), xlab = "Time", ylab = "Temperature")
points(3.1678, approx(table$Age.Ma, table$tempC_5pt, 3.1678)$y, col = "red", cex = 2, pch = 19) # Heuchera X Mitella
points(3.6155, approx(table$Age.Ma, table$tempC_5pt, 3.6155)$y, col = "red", cex = 2, pch = 19) # Tolmiea
points(4.0046, approx(table$Age.Ma, table$tempC_5pt, 4.0046)$y, col = "red", cex = 2, pch = 19) # Holochloa group
points(2.8602, approx(table$Age.Ma, table$tempC_5pt, 2.8602)$y, col = "red", cex = 2, pch = 19) # H. wootonii
points(1.0687, approx(table$Age.Ma, table$tempC_5pt, 1.0687)$y, col = "red", cex = 2, pch = 19) # H. grossulariifolia 4x
points(0.9131, approx(table$Age.Ma, table$tempC_5pt, 0.9131)$y, col = "red", cex = 2, pch = 19) # H. grossulariifolia 2x
points(1.6625, approx(table$Age.Ma, table$tempC_5pt, 1.6625)$y, col = "red", cex = 2, pch = 19) # H. duranii
points(2.5913, approx(table$Age.Ma, table$tempC_5pt, 2.5913)$y, col = "red", cex = 2, pch = 19) # Ozomelis group
points(1.3868, approx(table$Age.Ma, table$tempC_5pt, 1.3868)$y, col = "red", cex = 2, pch = 19) # Heucheras inside Ozomelis group
points(1.3868, approx(table$Age.Ma, table$tempC_5pt, 1.3868)$y, col = "red", cex = 2, pch = 19) # Heucheras inside Ozomelis group
points(0.8246, approx(table$Age.Ma, table$tempC_5pt, 0.8246)$y, col = "red", cex = 2, pch = 19) # H. parvifolia var. utahensis
points(0.3071, approx(table$Age.Ma, table$tempC_5pt, 0.3071)$y, col = "red", cex = 2, pch = 19) # H. glabra
points(1.3819, approx(table$Age.Ma, table$tempC_5pt, 1.3819)$y, col = "red", cex = 2, pch = 19) # Tiarella cordifolia
points(1.7219, approx(table$Age.Ma, table$tempC_5pt, 1.7219)$y, col = "red", cex = 2, pch = 19) # Heuchera subsect. Heuchera
points(1.5220, approx(table$Age.Ma, table$tempC_5pt, 1.5220)$y, col = "red", cex = 2, pch = 19) # Within Heuchera subsect. Heuchera
points(0.8240, approx(table$Age.Ma, table$tempC_5pt, 0.8240)$y, col = "red", cex = 2, pch = 19) # Within Heuchera subsect. Heuchera # 2
points(2.31, approx(table$Age.Ma, table$tempC_5pt, 2.31)$y, col = "red", cex = 2, pch = 19) # MRCA(A. kiusiana, A. kumaensis)
points(1.15, approx(table$Age.Ma, table$tempC_5pt, 1.15)$y, col = "red", cex = 2, pch = 19) # MRCA(A. stylosa, A. acerina)

# Perform correlation

correl <- data.frame(age = c(3.1678, 3.6155, 4.0046, 2.8602, 1.0687,0.9131, 1.6625, 2.5913, 1.3868, 1.3868, 0.8246, 0.3071, 1.3819, 1.7219, 1.5220, 0.8240, 2.31, 1.15), temp = c(approx(table$Age.Ma, table$tempC_5pt, 3.1678)$y, approx(table$Age.Ma, table$tempC_5pt, 3.6155)$y, approx(table$Age.Ma, table$tempC_5pt, 4.0046)$y, approx(table$Age.Ma, table$tempC_5pt, 2.8602)$y, approx(table$Age.Ma, table$tempC_5pt, 1.0687)$y, approx(table$Age.Ma, table$tempC_5pt, 0.9131)$y, approx(table$Age.Ma, table$tempC_5pt, 1.6625)$y, approx(table$Age.Ma, table$tempC_5pt, 2.5913)$y, approx(table$Age.Ma, table$tempC_5pt, 1.3868)$y, approx(table$Age.Ma, table$tempC_5pt, 1.3868)$y, approx(table$Age.Ma, table$tempC_5pt, 0.8246)$y, approx(table$Age.Ma, table$tempC_5pt, 0.3071)$y, approx(table$Age.Ma, table$tempC_5pt, 1.3819)$y, approx(table$Age.Ma, table$tempC_5pt, 1.7219)$y, approx(table$Age.Ma, table$tempC_5pt, 1.5220)$y, approx(table$Age.Ma, table$tempC_5pt, 0.8240)$y, approx(table$Age.Ma, table$tempC_5pt, 2.31)$y, approx(table$Age.Ma, table$tempC_5pt, 1.15)$y))
summary(lm(age ~ temp, data = correl))
