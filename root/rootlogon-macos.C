{
  gROOT->ProcessLine(".L ~/.rootstyle.C");
  gROOT->ProcessLine(".include /Users/sjoosten/.local/opt/json_3.6.1/include");
  gROOT->ProcessLine(".include /Users/sjoosten/.local/opt/fmt_5.3.0/include");
  R__LOAD_LIBRARY(/Users/sjoosten/.local/opt/fmt_5.3.0/lib/libfmt.dylib);

  gSystem->Load("libTree");
  gSystem->Load("libTreePlayer");
  gSystem->Load("libHist");
//  gSystem->Load("libGenVector");
  gSystem->SetBuildDir("$HOME/.root_build_dir");
  set_style();
}
