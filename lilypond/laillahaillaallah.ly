\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c'' {
  \clef treble
  \key b \major
  \time 4/4 
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
			\repeat volta 2 {
				b4 r8 b a4 b | b4 r8 b a4 b |
				b4 r8 b a4 b | b8 b r b c2 |
			}
		}
}

text =  \lyricmode {
	lā i -- lā -- ha 
	lā i -- lā -- ha 
	lā i -- lā -- ha 
	il -- lā Al -- lāh
}

bass = \relative c, {
	\clef bass
  \key b \major
  \time 4/4 
	f4 r8 f a4 b | c r8 c dis4 e |
	fis4 r8 fis a4 b | c8 c r dis dis2 | 
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
    }
    \new PianoStaff  <<
    \new Staff = "voice" \melody
    \new Lyrics \lyricsto "words" \text
    \new Staff = "violin" \bass
  	>>
  >>
  \layout { 
   #(layout-set-staff-size 16)
   }
  \midi { 
  	\tempo 4 = 125
  }
}