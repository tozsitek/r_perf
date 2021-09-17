library(pdq)

#arrivRate    = 75
#service_rate = 100
#service_time = 1/service_rate
arrival.rate <- 0.5 * 2 # cust / min
service.time <- 1.5 # mins
#---- Initialize --------------------------------------------------------------

Init("Homework")
#SetComment("A simple M/M/1 queue")

#---- Define the queueing center ----------------------------------------------

#CreateNode("server", CEN, FCFS)
CreateMultiNode(2, "Checkout", MSQ, FCFS)

#---- Define the workload and circuit type ------------------------------------

CreateOpen("Shoppers", arrival.rate)

SetWUnit("Cust")
SetTUnit("Min")

#---- Define service demand due to workload on the queueing center ------------

SetDemand("Checkout", "shoppers", service.time)

#---- Solve the model ---------------------------------------------------------
#  Must use the CANONical method for an open circuit

Solve(CANON)

#---- Generate a report -------------------------------------------------------

Report()
