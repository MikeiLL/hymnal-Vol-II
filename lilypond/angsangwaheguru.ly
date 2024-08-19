\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c'' {
  \clef treble
  \key c \major
  \time 4/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
			 \repeat unfold 4 { 
			 	c2 d | d4 d8 e e4. r8 | 
			 	d4 d8 e e4. r8 | d4 d8 e e4. r8 |
			}
		}
	}
}

text =  \lyricmode {
	\repeat unfold 4 {
		Ang Sang Wa -- he Gu -- ru
		Wa -- he Gu -- ru Wa -- he Gu -- ru
	}
}

changes = \chordmode {
	c1 | a:min | d:min | g:7 |
	a:min | a:min/g | f | e:7 |
	d:m | a:m | d:m | a:7 |
	d:m | b:m7.5- | g:7 | f |
}
 
harmonies = \chordmode {
\set noChordSymbol = "" 
 \changes
}

\score {
  <<
    \new ChordNames {
      \set chordChanges = ##t
      \harmonies
    }
    \new Staff = "voice" \melody
    \new Lyrics \lyricsto "words" \text
  >>
  \layout { 
   # (layout-set-staff-size 16)
   \context { \ChordNames
     \override ChordName #'font-size = #1
  	} 
  }
  \midi { 
  	\tempo 4 = 116
  }
}