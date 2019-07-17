{
  gROOT->ProcessLine(".L ~/.rootstyle.C");
  gROOT->ProcessLine(".include /usr/include");
  gROOT->ProcessLine(".include /usr/local/include");
  gSystem->Load("libTree");
  gSystem->Load("libTreePlayer");
  gSystem->Load("libHist");
  gSystem->Load("/usr/local/lib/libfmt.so");
  //  gSystem->Load("libGenVector");
  gSystem->SetBuildDir("$HOME/.root_build_dir");
  set_style();
}
