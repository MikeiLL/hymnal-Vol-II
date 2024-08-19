\version "2.19.45"
\paper {
	line-width = 4.6\in
}

\header {
  composer = "Raga as received by Jagadisha"
}

melody = \relative c'' {
  \clef treble
  \key g \major
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
			e c b a | c8( b) c b fis b a4 |
			fis b8 b c4 b | e8 c b a fis b a4 |
			e' fis a fis | e8 fis a b c b a4 |
			fis8( a16 fis) e4 c8( e16 c) b4 | c8( b) c b c b a4 |
		}
		
		\repeat volta 2 {
			a'8 fis4 e8 c b a4 | r8 fis a b c e fis4 |
			a8 fis4 e8 c b a4  | fis8 a4 b8 c( b) a4 |
		}
		
		\repeat volta 2 {
			a8. a16 b8 b c4 e | fis8. fis16 e8 e c4 b |
			a8. a16 b8 b c4 e | fis8. fis16 e8 e c8( b) a4 |
		}
		
		\repeat volta 2 {
			fis'8. fis16 e8 e c4 e | fis8. fis16 a8 a b4 c |
			c8. c16 b8 b a4 fis | e8. e16 c8 c c8( b) a |
		}
  }
}

text =  \lyricmode {
	\set associatedVoice = "words"
	Om Ma Sri Ma | A__ -- nan -- da -- ma -- yi Ma |
	Om Pri -- ya At -- man | Cit -- ti shak -- ti gu -- ru Ma | % awake conscious energy shakti
	Om Ma Sri Ma | Ku -- la  Kun -- da -- li -- ni Ma |
	Om Ma Sri Ma | A__ -- nan -- da -- ma -- yi Ma |
	Shi -- va -- ya na -- maḥ Om | Shi -- va -- ya na -- ma__ -- ḥ  |
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
    \new Staff {
    	\new Voice = "one" { \melody }
  	}
    \new Lyrics \lyricsto "words" \text
  >>
  \layout { 
   #(layout-set-staff-size 16)
   }
  \midi { 
  	\tempo 4 = 125
  }
}