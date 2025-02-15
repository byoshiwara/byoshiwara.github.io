var ptx_lunr_search_style = "textbook";
var ptx_lunr_docs = [
{
  "id": "homepage",
  "level": "1",
  "url": "homepage.html",
  "type": "Article",
  "number": "",
  "title": "Yoshiwara stuff",
  "body": "Yoshiwara stuff    Bruce Yoshiwara Department of Retirement  Leisure U  Atascadero, CA  byoshiwara(at)gmail(dot)com         I recently realized with dismay that I am even too old now for early onset dementia. Any dementia I get will be right on time.    Bill Bryson, The Road to Little Dribbling   My main current project is to assist with the production of Katherine Yoshiwara's developmental math textbooks into free html versions via PreTeXt .    Kathy's Books  Besides her online textbooks listed in the approved textbooks list of Open Textbook Initiative (a project of the American Institute of Mathematics ), draft versions of Katherine Yoshiwara's new or revised books include   Modeling, Functions, and Graphs with its Algebra Toolkit . Each has a pdf version available upon request.   Modeling, Functions, and Graphs with embedded WeBWorK exercises within the exposition.   Trigonometry and a pdf version available upon request.   Intermediate Algebra    Elementary Algebra and a pdf version available upon request.     For grins  If you are reading this page on a computer screen or similarly large display, there should be a \"Calc\" button near the left edge of the browser window, just above the text. Clicking on it should launch a Geogebra graphing calculator in the right margin. Kathy's college algebra textbook includes an appendix giving some instructions for using the app.   Bio  Bruce Yoshiwara earned four degrees from UCLA: B.A., M.A., C.Phil., and Ph.D. in mathematics.  He taught full-time at L.A. Pierce College 1989 2014, except for a Fulbright Teacher Exchange at Barnsley College, England, in 1998 1999, and a sabbatical leave in 2005 2006 (both with his lovely wife Professor Katherine Yoshiwara ). He received the 2008 Award for Distinguished College or University Teaching of Mathematics from the Southern California-Nevada Section of the MAA, a 2009 Teaching Excellence Award from AMATYC, and a 2011 Hayward Award for Excellence in Education from the Board of Governors of the California Community Colleges. He has served on the governing board of the Southern California-Nevada Section of the MAA, executive board of AMATYC, the governing board of CMC3-South, the California Mathematics Curriculum Framework and Evaluation Criteria Committee, and the advisory board of the MAA Mathematical Sciences Digital Library, chaired the \"Before Calculus\" proposal review committee for the International Conference on Technology in Collegiate Mathemtics (ICTCM), been an associate editor for the online math journal Loci , a consultant for Project NExT, a mentor for Project ACCCESS, a Content Review Panelist evaluating instructional materials for California's Mathematics Primary Adoption, a member of the writing team for UCLA's Mathematics Content Program for Teachers, and the Implementation Coordinator for AMATYC's Beyond Crossroads .  Since retirement he has served on the MAA's Haimo Distinguished Teaching Award committee, as secretary for the MAA Southern California-Nevada Section, as advisor to the NSF-funded StatPREP grant, mentor to Project ACCCESS fellows, member of AMATYC IMPACT steering commmittee, and member of multiple AMATYC task forces.   A photo of us at Leelanau Peninsula (Michigan), courtesy of Jim Ham  Just Us, summer 2019     This webpage was authored in PreTeXt.   "
}
]

var ptx_lunr_idx = lunr(function () {
  this.ref('id')
  this.field('title')
  this.field('body')
  this.metadataWhitelist = ['position']

  ptx_lunr_docs.forEach(function (doc) {
    this.add(doc)
  }, this)
})
