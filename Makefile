#########################################################################
### 
### Boilerplate Makefile by Bret Mogilefsky (mogul@playstation.sony.com)
### 	with heaps of help from Tyler Daniel
###
### Use this makefile as a template for new projects!
### 
### General Features:
###
###	Just specify SRCS and go!
###	Automatic and minimal (fast!) dependency generation (for vu microcode as well)
###	Allows keeping source and headers from src and include dirs, or elsewhere.
###	Builds in a subdirectory.
###	Allows additional defines, include dirs, and lib dirs without 
###		specifying -D, -I, and -L
###   Easy to specify parallel builds (debug, optimized, release, etc)
###   Easy to add flags on a per-file, per-build, or per-file-build basis
###	Can specify parent projects to make first (libraries)
###	Builds libraries
###	Slices, dices, feeds your cat, calls your mum.
###
### VU microcode features:
###
###	Generates depencies for microcode (for .include and #include)
###	Uses a preprocessing script to manage registers (configurable)
###	Runs the c preprocessor over microcode - you can use #define and #include
###		freely (and share #defines with c/c++)
###	Support for vcl
###
### Useful targets:
###
###	run		Run the executable.
###	xrun		Run the executable under a new xterminal.
###	clean		Remove everything we can rebuild.
###	tags		Generate source-browsing tags for Emacs.
###
### Using builds:
###
### 	To specify a particular build include the name of the build anywhere on
### 	the command line:
### 		make xrun optimized,
###   	make clean optimized, etc.
###
### 	Included builds (add your own!):
### 		debug
###		optimized	(default)
###		release
###
###	For more info see the "Build Options" section below
##########################################################################


##########################################################################
### Target
##########################################################################


# The name of the binary file we want to generate.  Also handles libraries! (.a)
TARGET		= rof.elf


##########################################################################
### Files and Paths - this is probably the only section you'll need to change
##########################################################################


# The source files for the project.
# get all cpp source files
SRCS		+= $(wildcard *.cpp)
SRCS		+= $(foreach DIR,$(SRCDIRS),$(subst $(DIR)/,,$(wildcard $(DIR)/*.cpp)))
# get all c source files
SRCS		+= $(wildcard *.c)
SRCS		+= $(foreach DIR,$(SRCDIRS),$(subst $(DIR)/,,$(wildcard $(DIR)/*.c)))

# .. or add them manually
#SRCS += ...


#SRCS		+= $(foreach DIR,$(SRCDIRS),$(subst $(DIR)/,,$(wildcard $(DIR)/*.cpp)))

# Additional objects to link. Only add things that aren't built from SRCS!
OBJS		= 

# Additional libs to link with.
LIBS		+= 


# Additional locations for header files
INCDIRS		+= src src/math src/objects src/lights src/util src/util/tinyxml

# Additional locations for library files
LIBDIRS		+= 

# Additional locations for source files
SRCDIRS		= src src/math src/objects src/lights src/util src/util/tinyxml src/GUI

# Object files and the target will be placed in this directory with an
# underscore and the buildname appended (e.g., for the "debug" build: objs_debug/)
OBJDIRBASE	= objs

# Dependency files will be placed in this directory with an underscore and
# the buildname appended (e.g., for the "debug" build: deps_debug/)
DEPDIRBASE	= deps

# If this project depends other projects (a ps2 rendering library for example) that should
# be built with make before making this one, list the directories here.
MAKEPARENTS	= 


##########################################################################
### Common Options (shared across builds)
##########################################################################

# link against libraries
#LIBS		+= libstdc++.a

# find headers
INCDIRS		+= /usr/include

# find  libraries
LIBDIRS		+= /usr/lib /usr/X11R6/lib

# Additional preprocessor definitions
DEFINES		= 

# Compiler optimization options
OPTFLAGS	= -Wall -pedantic -W -fpermissive

# Compiler debug options

# enable all warnings
DEBUGFLAGS	= -Wall -pedantic -W

# Command-line arguments to be passed to the target when we run it
RUNARGS		= 


##########################################################################
### Build Options - applied per-build
##########################################################################


# Which build to do if none is specified on the command line
DEFAULTBUILD		= optimized

################# application ####################

# Specifics for the "debug" build
BUILDNAMES		+= debug
debug_DEBUGFLAGS	= -DDEBUG -DVERBOSE -DSTATS -g 
debug_SRCS		= 

# Specifics for the "optimized" build 
BUILDNAMES				+= optimized
optimized_DEBUGFLAGS	= -DDEBUG -g
optimized_OPTFLAGS	= -ffast-math -O2
optimized_SRCS		= 

# Specifics for the "release" build
BUILDNAMES		+= release
release_OPTFLAGS	= -ffast-math -O3
release_SRCS		= 



# You can specify flags for a new build type "hamburger" as follows:
# BUILDNAMES		+= hamburger
# hamburger_INCDIRS	= someincdirs
# hamburger_LIBDIRS	= somelibdirs
# hamburger_DEFINES	= somedefs
# hamburger_OPTFLAGS	= someoptflags
# hamburger_DEBUGFLAGS	= somedebugflags
# hamburger_RUNARGS	= somerunargs


##########################################################################
### Per-file Options
##########################################################################


# Additional defines and include dirs can be specified on a per-file basis
# by prefixing with the stem of the filename.  For example, if I wanted special flags
# for building mucilage.cpp, I could add any of the following 
# mucilage_INCDIRS	= someincdirs 
# mucilage_LIBDIRS	= somelibdirs
# mucilage_DEFINES	= somedefs
# mucilage_OPTFLAGS	= someoptflags
# mucilage_DEBUGFLAGS	= somedebugflags


##########################################################################
### Per-file, per-build Options
##########################################################################


# Similar to above.. To apply special flags for building mucilage.cpp for
# the debug build, I could add any of the following
# mucilage_debug_INCDIRS	= someincdirs 
# mucilage_debug_LIBDIRS	= somelibdirs
# mucilage_debug_DEFINES	= somedefs
# mucilage_debug_OPTFLAGS	= someoptflags
# mucilage_debug_DEBUGFLAGS	= somedebugflags


##########################################################################
### Makefile operation
##########################################################################


# Set this to 1 to print status messages (like 'Compiling somefile.cpp...')
PRINT_MSGS		= 1

# Set this to 1 to print the exact command lines used to build files
PRINT_CMDS		= 0


##########################################################################
### include the makefile that does all the work
##########################################################################

include Makefile.work
