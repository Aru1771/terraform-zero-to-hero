Provider:
=========

* In terrafrom Provider Plugin play a key role.
* It briges the gap b/w the cloud provider and terrafrom.
* it will converts our terrafrom code into clouder provider understandable way.
* it will directly communicate with Cloud provider API.

1) How we init a provider ?
   cmd: terrafrom init

* In the provider block we have to mention two versions.
  1. related to aws provider.
  2. related to terrafrom provider.


Simple way to remember the provider block have:
------------------------------------------------

terrafrom {

required_providers{

 --->this is related to aws provider version <------

}

required_version {

}


}

provider ""{



}

* always stick to the version where we developed our code and test the code.
* if we use diff version may be we see so many compatability issues.
* always lock the provider version and terrafrom version with the help of : ---------> version = "~>6.1.0"
* what this lock above i have locked the version so it will allow only minor patched to upgrede like 6.1.1 to 6.1.10 but i will not upgrade to 7.1.0 if it available.
* we can use >, < , = , >=, <= all these operaters.
  



