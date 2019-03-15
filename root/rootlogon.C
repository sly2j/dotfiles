{
  gROOT->ProcessLine(".L ~/.rootstyle.C");
  gSystem->Load("libTree");
  gSystem->Load("libTreePlayer");
  gSystem->Load("libHist");
//  gSystem->Load("libGenVector");
  gSystem->SetBuildDir("$HOME/.root_build_dir");
  set_style();
}
