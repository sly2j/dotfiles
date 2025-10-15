{
  // quiet kInfo messages (kPrint, kInfo, kWarning, kError, ...)
  gErrorIgnoreLevel = kWarning;
  gROOT->ProcessLine(".L ~/.rootstyle.C");
  R__LOAD_LIBRARY(/opt/homebrew/lib/libfmt.dylib);
  gROOT->ProcessLine(".include "
                     "/opt/homebrew/include/root");
  gROOT->ProcessLine(".include "
                     "/opt/homebrew/include");

  gSystem->Load("libTree");
  gSystem->Load("libTreePlayer");
  gSystem->Load("libHist");
  //  gSystem->Load("libGenVector");
  gSystem->SetBuildDir("$HOME/.root_build_dir");
  set_style();
}
