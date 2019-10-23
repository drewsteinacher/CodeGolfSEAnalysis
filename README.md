# CodeGolfSEAnalysis
A data science project to analyze [codegolf.stackexchange.com](https://codegolf.stackexchange.com) in a [Wolfram Language](https://www.wolfram.com/language/) [EntityStore](https://reference.wolfram.com/language/ref/EntityStore.html)

## Requirements
A version 12 or newer [Wolfram Engine](https://www.wolfram.com/products/) product.

## Getting Started
I've listed the rough steps I took here in order if you're interested in the details of how I processed the data.
But you may want to save yourself some time and effort by skipping to the exploration section and downloading the cleaned and processed store.

### Generating an EntityStore from XML snapshots
The latest XML snapshots of codegolf.stackexchange.com can be found [here](https://archive.org/download/stackexchange/codegolf.stackexchange.com.7z) on [archive.org](https://archive.org/), along with the other [StackExchange network archives](https://archive.org/details/stackexchange).
Code and directions for converting these into a [Wolfram Language](https://www.wolfram.com/language/) [EntityStore](https://reference.wolfram.com/language/ref/EntityStore.html) are currently TBD as the conversion utility is made public-ready.
But for now, you can download a compressed MX file of a converted EntityStore [here](https://www.wolframcloud.com/obj/andrews/StackExchange2EntityStore/codegolf.stackexchange.com.mx.zip) (~418 MB). 

### Gathering codegolf-specific metadata
Follow along with the code in GatherMetadata.nb to collect submission information including programming languages, reported sizes, and code snippets.

### Cleaning and processing metadata
Follow along with the code in ProcessMetadata.nb to further refine the metadata, merge unnecessarily duplicated language entities and add additional properties to the EntityStore for fast and easy exploration.

### Exploration
There is a lot of interesting data to explore and extract, but I've done some work on things I found interesting in Explore.nb.
I've uploaded a [public version of this notebook](https://www.wolframcloud.com/obj/andrews/Published/CodeGolfSE-Explore.nb) for easy viewing on the [Wolfram Cloud](https://www.wolframcloud.com/).

If you'd like to do some exploration on your own, you can download compressed MX files of the cleaned and processed EntityStores here:
 * [codegolf.stackexchange.com_Cleaned.mx.zip](https://www.wolframcloud.com/obj/andrews/StackExchange2EntityStore/codegolf.stackexchange.com_Cleaned.mx.zip) (~450 MB)
 * [CodeGolfProgrammingLanguage_Cleaned.mx.zip](https://www.wolframcloud.com/obj/andrews/StackExchange2EntityStore/CodeGolfProgrammingLanguage_Cleaned.mx.zip) (~325 KB)
 
After extracting the files, you should be able to follow along with the code in Explore.nb and go from there.
