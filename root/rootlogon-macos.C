{
  gROOT->ProcessLine(".L ~/.rootstyle.C");
  //  gROOT->ProcessLine(".include
  //  /Users/sjoosten/.local/opt/json_3.7.3/include");
  //  gROOT->ProcessLine(".include
  //  /Users/sjoosten/.local/opt/fmt_6.1.2/include");
  // R__LOAD_LIBRARY(/Users/sjoosten/.local/opt/fmt_6.1.2/lib/libfmt.dylib);
  // R__LOAD_LIBRARY(libfmt);
  gROOT->ProcessLine(".include "
                     "/opt/homebrew/include/root");

  gSystem->Load("libTree");
  gSystem->Load("libTreePlayer");
  gSystem->Load("libHist");
  //  gSystem->Load("libGenVector");
  gSystem->SetBuildDir("$HOME/.root_build_dir");
  set_style();
}
