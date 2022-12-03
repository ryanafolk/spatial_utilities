# run like so:
# python3 average_gtifs.py average.tif --infiles *.tif 

from osgeo import gdal
import numpy as np
import argparse

parser = argparse.ArgumentParser(description='Script to average arbitrary number of GTIFs.')
parser.add_argument('outfile', action='store', help='Name of the desired pre-coded output file.')
parser.add_argument('-x','--infiles', nargs='+', help='List of discrete column headers.', required=True)
args = parser.parse_args()

file_paths = args.infiles
outfile = args.outfile

# We build one large np array of all images (this requires that all data fits in memory)
res = []
for f in file_paths:
    ds = gdal.Open(f)
    res.append(ds.GetRasterBand(1).ReadAsArray()) # We assume that all rasters has a single band
stacked = np.dstack(res) # We assume that all rasters have the same dimensions
mean = np.mean(stacked, axis=-1)

# Finally save a new raster with the result. 
# This assumes that all inputs have the same geotransform since we just copy the first
driver = gdal.GetDriverByName('GTiff')
result = driver.CreateCopy(outfile, gdal.Open(file_paths[0]))
result.GetRasterBand(1).WriteArray(mean)
result = None