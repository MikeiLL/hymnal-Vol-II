\version "2.19.45"
\paper {
	line-width = 4.6\in
}

\header {
  composer = "Raga as received by Jagadisha"
}

melody = \relative c'' {
  \clef treble
  \key ges \major
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
			ees ces bes aes | ces8( bes) ces bes f bes aes4 |
			f bes8 bes ces4 bes | ees8 ces bes aes f bes aes4 |
			ees' f aes f | ees8 f aes bes ces bes aes4 |
			f8( aes16 f) ees4 ces8( ees16 ces) bes4 | ces8( bes) ces bes ces bes aes4 |
		}
		
		\repeat volta 2 {
			aes'8 f4 ees8 ces bes aes4 | r16 f8 aes16~ aes8 bes ces ees f4 |
			aes8 f4 ees8 ces bes aes4  | f8 aes4 bes8 ces( bes) aes4 |
		}
		
		\repeat volta 2 {
			aes8. aes16 bes8 bes ces4 ees | f8. f16 ees8 ees ces4 bes |
			aes8. aes16 bes8 bes ces4 ees | f8. f16 ees8 ees ces8( bes) aes4 |
		}
		
		\repeat volta 2 {
			f'8. f16 ees8 ees ces4 ees | f8. f16 aes8 aes bes4 ces |
			ces8. ces16 bes8 bes aes4 f | ees8. ees16 ces8 ces ces8( bes) aes |
		}
  }
}

text =  \lyricmode {
	\set associatedVoice = "words"
	Om Ma Sri Ma | A__ -- nan -- da -- ma -- yi Ma |
	Om Pri -- ya At -- man | Cit -- ti shak -- ti gu -- ru Ma | % awake conscious energy shakti
	Om Ma Sri Ma | Ku -- la  Kun -- da -- li -- ni Ma |
	Om Ma Sri Ma | A__ -- nan -- da -- ma -- yi Ma |
	Shi -- va -- ya na -- maḥ Om | Shi -- va -- ya na -- ma__ -- ḥ   |
	Shi -- va -- ya na -- maḥ Om | na -- maḥ Shi -- va -- ya |
	Om na -- maḥ Shi -- va -- ya | Om na -- maḥ Shi -- va -- ya |
	Om na -- maḥ Shi -- va -- ya | Om na -- maḥ Shi -- va -- ya |
	Om na -- maḥ Shi -- va -- ya | Om na -- maḥ Shi -- va -- ya |
	Om na -- maḥ Shi -- va -- ya | Om na -- maḥ Shi -- va -- ya |
}

\score {
  <<
    \new ChordNames {
      \set chordChang = ##t
    }
    \new Staff \with { \magnifyStaff #5/7 } {
    	\new Voice = "one" { \melody }
  	}
    \new Lyrics \lyricsto "words" \text
  >>
  \layout { 
   % #(layout-set-staff-size 14)
   }
  \midi { 
  	\tempo 4 = 125
  }
}