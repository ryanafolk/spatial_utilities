# File input based on https://stackoverflow.com/questions/57819013/how-to-calculate-a-raster-mean-average-from-individual-maps-using-gdal-in-python
# Distance matrix based on https://github.com/ryanafolk/eco-discretizer/

# Run like so (Heuchera project):

# python3 distancematrix_gtifs.py distancematrix.csv --infiles *.tif





from osgeo import gdal
import numpy
import argparse
import itertools
import pandas

parser = argparse.ArgumentParser(description='Script to average arbitrary number of GTIFs.')
parser.add_argument('outfile', action='store', help='Name of the desired pre-coded output file.')
parser.add_argument('-x','--infiles', nargs='+', help='List of discrete column headers.', required=True)
args = parser.parse_args()

file_paths = args.infiles
outfile = args.outfile

# We build one large numpy array of all images (this requires that all data fits in memory)
res = []
for f in file_paths:
    ds = gdal.Open(f)
    res.append(ds.GetRasterBand(1).ReadAsArray()) # We assume that all rasters has a single band

#stacked = np.dstack(res) # We assume that all rasters have the same dimensions





distanceDataFrame = pandas.DataFrame(data=numpy.zeros((len(res), len(res))), index=file_paths, columns=file_paths) # Empty dataframe to hold species pairwise distances 
for column_raster, column in zip(res, file_paths):
	print("Distance matrix: on raster {0}.".format(column))
	for row_raster, row in zip(res, file_paths):
		distance = numpy.linalg.norm(numpy.nan_to_num(row_raster) - numpy.nan_to_num(column_raster)) # Numpy formula for Euclidean distance
		distanceDataFrame.at[row, column] = distance # Populate dataframe with distance



print(distanceDataFrame)


# Process and write the matrix
for i in file_paths: 
	distanceDataFrame.at[i, i] = None # Clearing out the diagonal
distanceDataFrame.to_csv(outfile)


#all_pairs = list(itertools.product(res, repeat = 2))
#pair1 = []
#pair2 = []
#for a, b in all_pairs:
#	pair1.append(a)
#	pair2.append(b)
#	
#
#print(all_pairs[1])
#print(len(all_pairs))
#
#print(len(pair1))
#
#distance_matrix = spatial.distance_matrix(pair1, pair2, p = 2) # p = 2 is Euclidean
#
#print(distance_matrix)

## Finally save a new raster with the result. 
## This assumes that all inputs have the same geotransform since we just copy the first
#driver = gdal.GetDriverByName('GTiff')
#result = driver.CreateCopy(outfile, gdal.Open(file_paths[0]))
#result.GetRasterBand(1).WriteArray(mean)
#result = None