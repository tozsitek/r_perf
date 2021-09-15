# This is the R verion of the same PDQ model in the PPA book 1998
# and presented in the GCAP course.
# The architeture seems to be based on Novell Netware.
# PDQ C version cs_baseline.c is in the ppa_1998 folder.
#
# Created by NJG on Tue Dec 1, 2020

library(pdq)

# PDQ model scenario name and its baseline parameters
# Upgrades will reference this baseline model
scenario <- "Netware Baseline Model"
USERS		 <- 125 # desktop PCs
FS.disks <- 1  # Fileserver disks
MF.disks <- 4  # mainfrae DASD 


####################################################
# Nothing below this line should be edited
####################################################

#  Useful constants
K     =  1024
k			=  1e3
MIPS  =  1e6
Kbps 	=  K
Mbps 	=	 Kbps * Kbps
TPS 	=	 1/60

PC_MIPS <- 27 * MIPS
FS_MIPS	<- 41 * MIPS
GW_MIPS	<- 10 * MIPS
MF_MIPS	<- 21 * MIPS
TR_Mbps	<- 	4 * Mbps  # token ring LAN 
TR_Bytes <- 512 + 256 # data payload 

PC = 1    # desktops
FS = 2    # file server
GW = 3    # gateway
MF = 4    # mainframe

CD_Req  =  1
CD_Rpy  = 15
RQ_Req  = 2
RQ_Rpy  = 16
SU_Req  = 3
SU_Rpy  = 17
Req_CD	= 4
Req_RQ	= 5
Req_SU	= 6
CD_Msg	= 12
RQ_Msg	= 13
SU_Msg	= 14
GT_Snd	=  7
GT_Rcv	= 11
MF_CD	  =  8
MF_RQ   =  9
MF_SU	  = 10
TR_TX	  = 18 # token ring LAN


## Create a sparse matrix of service times
## Rows are workloads
## Cols are devices running the respective work
## Initialized with all zeros
stime <- matrix(0, nrow=18, ncol=(4 + FS.disks + MF.disks))
# print(stime)  # take a look at the matrix 

stime[CD_Req, PC] <- 200 * k / PC_MIPS
stime[CD_Rpy, PC] <- 100 * k / PC_MIPS
stime[RQ_Req, PC] <- 150 * k / PC_MIPS
stime[RQ_Rpy, PC] <- 200 * k / PC_MIPS
stime[SU_Req, PC] <- 300 * k / PC_MIPS
stime[SU_Rpy, PC] <- 300 * k / PC_MIPS

stime[Req_CD, FS] <-  50 * k / FS_MIPS
stime[Req_RQ, FS] <-  70 * k / FS_MIPS
stime[Req_SU, FS] <-  10 * k / FS_MIPS
stime[CD_Msg, FS] <-  35 * k / FS_MIPS
stime[RQ_Msg, FS] <-  35 * k / FS_MIPS
stime[SU_Msg, FS] <-  35 * k / FS_MIPS

stime[GT_Snd, GW] <- 50 * k / GW_MIPS
stime[GT_Rcv, GW] <- 50 * k / GW_MIPS

stime[MF_CD, MF]  <- 50 * k / MF_MIPS
stime[MF_RQ, MF]  <- 150 * k / MF_MIPS
stime[MF_SU, MF]  <- 20 * k / MF_MIPS

stime[TR_TX, PC] = TR_Bytes * 8 / TR_Mbps
stime[TR_TX, FS] = TR_Bytes * 8 / TR_Mbps
stime[TR_TX, GW] = TR_Bytes * 8 / TR_Mbps  
# print(stime) # take a look at the matrix 


# File server disk IOs = # accesses * caching / (max IOs/sec)
for (i in 1:FS.disks) {
    stime[Req_CD, 4 + i] = (1.0 * 0.5 / 128.9) / FS.disks
    stime[Req_RQ, 4 + i] = (1.5 * 0.5 / 128.9) / FS.disks
    stime[Req_SU, 4 + i] = (0.2 * 0.5 / 128.9) / FS.disks
    stime[CD_Msg, 4 + i] = (1.0 * 0.5 / 128.9) / FS.disks
    stime[RQ_Msg, 4 + i] = (1.5 * 0.5 / 128.9) / FS.disks
    stime[SU_Msg, 4 + i] = (0.5 * 0.5 / 128.9) / FS.disks
}


# Mainframe DASD IOs = (#accesses / (max IOs/sec)) / #disks
for (i in 1:MF.disks) {
    stime[MF_CD, 4 + FS.disks + i] = (2.0 / 60.24) / MF.disks
    stime[MF_RQ, 4 + FS.disks + i] = (4.0 / 60.24) / MF.disks
    stime[MF_SU, 4 + FS.disks + i] = (1.0 / 60.24) / MF.disks
}
  

####################################################
## Now, start building the PDQ model
####################################################
Init(scenario);

# Define the TRANSACTION workloads 
CreateOpen("CatDisplay", 1 * 4.0 * TPS)
CreateOpen("RemotQuote", 1 * 8.0 * TPS)
CreateOpen("StatUpdate", 1 * 1.0 * TPS)
CreateOpen("CatDispAgg", (USERS - 1) * 4 * TPS)
CreateOpen("RemQuotAgg", (USERS - 1) * 8 * TPS)
CreateOpen("StatUpdAgg", (USERS - 1) * 1 * TPS)

# Define the physical computational resources 
CreateNode("PCdesk", CEN, FCFS)
CreateNode("FileSrv", CEN, FCFS)
CreateNode("Gateway", CEN, FCFS)
CreateNode("Mainframe", CEN, FCFS)
CreateNode("TokenRing", CEN, FCFS)

# Define filesever and mainframe storage devices
fsdk.name <- NULL
for (i in 1:FS.disks) {
  fsdk.name[i] <- paste("FSdisk", i)
  CreateNode(fsdk.name[i], CEN, FCFS);
}

mfdk.name <- NULL
for (i in 1:MF.disks) {
  mfdk.name[i] <- paste("MFdasd", i)
  CreateNode(mfdk.name[i], CEN, FCFS);
}



# Define the service stimes on each physical resource.
# CD request + reply chain from workflow diagram
# Note that only the "real" PC stime is defined, and 
# the aggregated (N-1) PC desktops.

#******************* CatDisplay request + reply chain ***************
SetDemand("PCdesk", "CatDisplay", stime[CD_Req, PC] + 
            (5 * stime[CD_Rpy, PC]))
SetDemand("FileSrv", "CatDisplay", stime[Req_CD, FS] + 
            (5 * stime[CD_Msg, FS]))
SetDemand("FileSrv", "CatDispAgg", stime[Req_CD, FS] + 
            (5 * stime[CD_Msg, FS]))
SetDemand("Gateway", "CatDisplay", stime[GT_Snd, GW] + 
            (5 * stime[GT_Rcv, GW]))
SetDemand("Gateway", "CatDispAgg", stime[GT_Snd, GW] + 
            (5 * stime[GT_Rcv, GW]))
SetDemand("Mainframe", "CatDisplay", stime[MF_CD, MF])
SetDemand("Mainframe", "CatDispAgg", stime[MF_CD, MF])

for (i in 1:FS.disks) {
  fsd = stime[Req_CD, 4 + i] + 
    (5 * stime[CD_Msg, 4 + i])
  SetDemand(fsdk.name[i], "CatDisplay", fsd)
  SetDemand(fsdk.name[i], "CatDispAgg", fsd)
}

for (i in 1:MF.disks) {
  SetDemand(mfdk.name[i], "CatDisplay", stime[MF_CD, 4 + FS.disks + i])
  SetDemand(mfdk.name[i], "CatDispAgg", stime[MF_CD, 4 + FS.disks + i])
}

# NOTE:Synchronous process execution causes data for the CD transaction 
# to traverse the Token Ring LAN 12 times as depicted in the following 
# parameterization of SetDemand.

SetDemand("TokenRing", "CatDisplay",
                (1 * stime[TR_TX, PC]) +
                  (1 * stime[TR_TX, FS]) +
                  (1 * stime[TR_TX, GW]) +
                  (5 * stime[TR_TX, GW]) +
                  (5 * stime[TR_TX, FS]) +
                  (5 * stime[TR_TX, PC]))

SetDemand("TokenRing", "CatDispAgg",
              (1 * stime[TR_TX, PC]) +
                (1 * stime[TR_TX, FS]) +
                (1 * stime[TR_TX, GW]) +
                (5 * stime[TR_TX, GW]) +
                (5 * stime[TR_TX, FS]) +
                (5 * stime[TR_TX, PC]))


##****************** RemotQuote request + reply chain *******************
SetDemand("PCdesk", "RemotQuote", stime[RQ_Req, PC] + 
            (3 * stime[RQ_Rpy, PC]))
SetDemand("FileSrv", "RemotQuote", stime[Req_RQ, FS] + 
            (3 * stime[RQ_Msg, FS]))
SetDemand("FileSrv", "RemQuotAgg", stime[Req_RQ, FS] + 
            (3 * stime[RQ_Msg, FS]))
SetDemand("Gateway", "RemotQuote", stime[GT_Snd, GW] + 
            (3 * stime[GT_Rcv, GW]))
SetDemand("Gateway", "RemQuotAgg", stime[GT_Snd, GW] + 
            (3 * stime[GT_Rcv, GW]))
SetDemand("Mainframe", "RemotQuote", stime[MF_RQ, MF])
SetDemand("Mainframe", "RemQuotAgg", stime[MF_RQ, MF])

SetDemand("TokenRing", "RemotQuote",
              (1 * stime[TR_TX, PC]) +
                (1 * stime[TR_TX, FS]) +
                (1 * stime[TR_TX, GW]) +
                (3 * stime[TR_TX, GW]) +
                (3 * stime[TR_TX, FS]) +
                (3 * stime[TR_TX, PC]))

SetDemand("TokenRing", "RemQuotAgg",
              (1 * stime[TR_TX, PC]) +
                (1 * stime[TR_TX, FS]) +
                (1 * stime[TR_TX, GW]) +
                (3 * stime[TR_TX, GW]) +
                (3 * stime[TR_TX, FS]) +
                (3 * stime[TR_TX, PC]))

for (i in 1:FS.disks) {
  fsd = stime[Req_RQ, 4 + i] + (3 * stime[RQ_Msg, 4 + i])
  SetDemand(fsdk.name[i], "RemotQuote", fsd)
  SetDemand(fsdk.name[i], "RemQuotAgg", fsd)
}

for (i in 1:MF.disks) {
  SetDemand(mfdk.name[i], "RemotQuote", stime[MF_RQ, 4 + FS.disks + i])
  SetDemand(mfdk.name[i], "RemQuotAgg", stime[MF_RQ, 4 + FS.disks + i])
}


##************* Status Update request + reply chain ***********
SetDemand("PCdesk", "StatUpdate", stime[SU_Req, PC] + 
            stime[SU_Rpy, PC])
SetDemand("FileSrv", "StatUpdate", stime[Req_SU, FS] + 
            stime[SU_Msg, FS])
SetDemand("FileSrv", "StatUpdAgg", stime[Req_SU, FS] + 
            stime[SU_Msg, FS])

SetDemand("Gateway", "StatUpdate", stime[GT_Snd, GW] + stime[GT_Rcv, GW])
SetDemand("Gateway", "StatUpdAgg", stime[GT_Snd, GW] + stime[GT_Rcv, GW])
SetDemand("Mainframe", "StatUpdate", stime[MF_SU, MF])
SetDemand("Mainframe", "StatUpdAgg", stime[MF_SU, MF])

for (i in 1:FS.disks) {
  fsd = stime[Req_SU, 4 + i] + stime[SU_Msg, 4 + i]
  SetDemand(fsdk.name[i], "StatUpdate", fsd)
  SetDemand(fsdk.name[i], "StatUpdAgg", fsd)
}

for (i in 1:MF.disks) {
  SetDemand(mfdk.name[i], "StatUpdate", stime[MF_SU, 4 + FS.disks + i])
  SetDemand(mfdk.name[i], "StatUpdAgg", stime[MF_SU, 4 + FS.disks + i])
}


SetDemand("TokenRing", "StatUpdate",
              (1 * stime[TR_TX, PC]) +
                (1 * stime[TR_TX, FS]) +
                (1 * stime[TR_TX, GW]) +
                (1 * stime[TR_TX, GW]) +
                (1 * stime[TR_TX, FS]) +
                (1 * stime[TR_TX, PC]));

SetDemand("TokenRing", "StatUpdAgg",
              (1 * stime[TR_TX, PC]) +
                (1 * stime[TR_TX, FS]) +
                (1 * stime[TR_TX, GW]) +
                (1 * stime[TR_TX, GW]) +
                (1 * stime[TR_TX, FS]) +
                (1 * stime[TR_TX, PC]));




##*************  Solve the model ************* 
SetWUnit("Trans")
Solve(STREAMING)
# Report()


####################################################
# Breakout individual PDQ metrics 
####################################################

#  Mean response times reported in the CMG paper
RTexpect <- c(0.2754, 0.2625, 0.1252, 0.2624, 0.2470, 0.1120)
wname <- c("CatDisplay", "RemotQuote", "StatUpdate", 
           "CatDispAgg", "RemQuotAgg", "StatUpdAgg")

cat(sprintf("\nBreakout metrics for \"%s\" with %d users\n\n", scenario, USERS)) 
cat(sprintf("Transaction\t    R (PDQ)\t  R (Expect)\n")) 
cat(sprintf("-----------\t    -------\t  ---------\n"))

for (work in 1:length(wname)) {
  RTpdq <- GetResponse(TRANS, wname[work])
  cat(sprintf("%-15s\t%10.4f\t%10.4f\n", wname[work], RTpdq, RTexpect[work]))
}

## cf. Output from cs_baseline.c 
# Transaction	      PDQ	    CMG paper
# -----------	    -------	  ---------
# CatDisplay     	0.2749	    0.2754
# RemotQuote     	0.2884	    0.2625
# StatUpdate     	0.1010	    0.1252
# CatDispAgg     	0.2489	    0.2624
# RemQuotAgg     	0.2605	    0.2470
# StatUpdAgg     	0.0787	    0.1120




