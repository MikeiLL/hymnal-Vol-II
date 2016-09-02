\version "2.19.45"
\paper {
	line-width = 4.6\in
}

melody = \relative c'' {
  \clef treble
  \key c \major
  \time 5/4
  \set Score.voltaSpannerDuration = #(ly:make-moment 4/4)
	\new Voice = "words" {
		\repeat volta 2 {
			\repeat volta 2 {
			 ees4 d8 c g'4 aes8 g4. | ees4 d8 c g'4 aes8 g4. |
			 fis4 ees8 fis ees4 d8 d4. | fis4 ees8 fis ees4 d8 d4. |
			 d4 d8 d d4 ees8 f4. | d4 d8 d d4 ees8 f4. |
			 g4 f8 ees ees4 f8 g4. | g4 f8 ees ees4 f8 g4. |
			 }
		 ees4 d8( c) g'2. | ees4 d8( c) g'2. |
		 fis4 g fis2. | fis4 g fis2. |
		 f4 g f2. | f4 g f2. |
		 ees4 f g2. | ees4 f g2. |
		 ees4 c g'2. | ees4 c g'2. |
		 fis4 g fis2. | fis4 g fis2. |
		 f4 g f2. | f4 g f2. |
		 g4 ees c2. | g'4 ees c2. |
		}
	}
}

text =  \lyricmode {
	Ard -- ha -- nā -- rī -- śva -- ra 
	(Ard -- ha -- nā -- rī -- śva -- ra)
	Ard -- ha -- nā -- rī -- śva -- ra 
	(Ard -- ha -- nā -- rī -- śva -- ra) 
	Ard -- ha -- nā -- rī -- śva -- ra 
	(Ard -- ha -- nā -- rī -- śva -- ra) 
	Ard -- ha -- nā -- rī -- śva -- ra 
	(Ard -- ha -- nā -- rī -- śva -- ra)
	I am she
	(I am she)
	I am he
	(I am he)
	I am they
	(I am they)
	Burn in me
	(Burn in me)
	I and I 
	(I and I)
	den -- ti -- ty
	(den -- ti -- ty)
	My -- ste -- ry
	(My -- ste -- ry)
	Bha -- va -- ni
	(Bha -- va -- ni)
}

changes = \chordmode {
	c1:m c4:m | c1:m c4:m | d1:7 d4:7 | d1:7 d4:7 |
  g1:7 g4:7 | g1:7 g4:7 | c1:m c4:m | c1:m c4:m |
}
 
harmonies = \chordmode {
\set noChordSymbol = "" 
 \changes
 \changes
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
   #(layout-set-staff-size 16)
   \context { \ChordNames
     \override ChordName #'font-size = #1
  	} 
  }
  \midi { 
  	\tempo 4 = 116
  }
}