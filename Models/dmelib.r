dmelib_check_dependencies <- function(rv) {
  # checking R version
  if ((USER_RVERSION == rv))
    cat(paste0("R version: ", USER_RVERSION))
  else
    warning(paste0("The R version in which the model was developed (", rv, ") is different from that you are using (", USER_RVERSION, ")"))
  
  listOfDependencies <- DEPENDENCIES[,1]
  
  # checking the version of packages installed by user and required by model
  outDateMsg <- "The following installed dependencies (packages) has a different version from that used by model\n"
  installedPackages <- USER_PACKINFO[USER_PACKINFO[,c("Package")] %in% listOfDependencies, c("Package", "Version")]
  
  if(any(installedPackages[,2] != DEPENDENCIES[which(DEPENDENCIES$lib == installedPackages[,1]),2])){
    for(i in 1:nrow(installedPackages)){
      if (installedPackages[i,2] != DEPENDENCIES[which(DEPENDENCIES$lib == installedPackages[i,1]),2]){
        outDateMsg <- paste0(outDateMsg, "\t", installedPackages[i, "Package"], ": ", installedPackages[i,2], "(installed) - ", DEPENDENCIES[which(DEPENDENCIES$lib == installedPackages[i,1]),2], "(used by model)\n")
        warning(outDateMsg)
        
        #Vetor com libraries desatualizadas
        for(i in 1:length(installedPackages)){
          if(installedPackages[i,2] < DEPENDENCIES[which(DEPENDENCIES$lib == installedPackages[i,1]),2]){
            install.packages(installedPackages[i], dependencies = TRUE)
          }
          
        }
        
      }
    }
  }
  
  # checking the uninstalled packages required by model
  uninstalledPackages <- listOfDependencies[!(listOfDependencies %in% USER_PACKINFO[,"Package"])]
  if (length(uninstalledPackages)) {
    warning(paste0("The following dependencies (packages) are not installed: ", paste(uninstalledPackages, collapse=", ")))
    
    for(i in 1:length(uninstalledPackages))
      install.packages(uninstalledPackages[i], dependencies = TRUE)
  }
  
}