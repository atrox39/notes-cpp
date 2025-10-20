#include <wx/wx.h>

class NotesApp : public wxApp {
  public:
    virtual bool OnInit();
};

class NotesFrame : public wxFrame {
  public:
    NotesFrame();
};

wxIMPLEMENT_APP(NotesApp);

bool NotesApp::OnInit() {
  NotesFrame* frame = new NotesFrame();
  frame->Show(true);
  return true;
}

NotesFrame::NotesFrame()
    : wxFrame(NULL, wxID_ANY, "Notes Application") {}
