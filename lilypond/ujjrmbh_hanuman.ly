\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c'' {
  \clef treble
  \key d \major
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
			\time 5/4
			a4 a g2~ g8 e16 f | 
			\time 4/4 e4 e8 d e r cis8. cis16 |
			cis4 cis8 r16 cis16 d4 d8 r16 d16 | e4 e8 r8 d8. d16 d4 |
			e8. e16 e4 g8. g16 g4 | \time 2/4 b4 b |
		}
  }
}

text =  \lyricmode {
	\set associatedVoice = "words"
	Ha -- nu -- man Ha -- nu -- man a -- na -- ha -- ta uj -- 
	jṛm -- bh uj -- jṛm -- bh uj -- jṛm -- bh om na -- maḥ
	om na -- maḥ Ha -- nu -- man sat nam
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