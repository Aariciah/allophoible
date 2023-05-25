Allophoible
===========

Allophoible is an extension of [Version 2.0 of the PHOIBLE database](https://github.com/phoible/dev/releases/tag/v2.0) with features for all phone segments that only occur as allophones and for additional phonemes that occur in eSpeak NG Output (From [Version 1.51](https://github.com/espeak-ng/espeak-ng/releases/tag/1.51)). We also include feature for some additional phones from [Version 1.0 of the UCLA Phonetic Corpus](https://github.com/xinjli/ucla-phonetic-corpus/releases/tag/v1.0) that are not in PHOIBLE for future research. The extended database used in our work is included as `allophoible.csv`. Furthermore, we defined features for additional diacritics and two other symbols which were not included in the original PHOIBLE feature definition data. These feature definitions are included as `additional-diacritic-features.csv` for reference.

In addition to the raw feature data files, we modified and extended the feature generation code for automatically extending the base PHOIBLE database. We do not include additional code or resources for reproducing the original PHOIBLE database, which can be found [here](https://github.com/phoible/dev/releases/tag/v2.0).

Format of new Phones
--------------------

New phone definitions are appended as new rows to the original PHOIBLE database and assigned to the previously unused "InventoryID" 0. The "Glottocode", "ISO6393", "LanguageName" and "SpecificDialect" fields are set to NA, since the same phones can occur as allophones in inventories of different languages. The "Source" field for new phones indicates, whether phones were taken from the allophones from PHOIBLE ("phoible"), from eSpeak NG output ("espeak-ng") or from the UCLA Phonetic Corpus ("ucla").

Complex segments from PHOIBLE or eSpeak NG sometimes consist of a mixture of vowels and consonant, in which case the "SegmentClass" can be ambiguous. For PHOIBLE allophones, we disambiguate in these cases by taking the segment class from the phoneme that the phone is an allophone of. For eSpeak NG, the field is left as NA in these cases.

Reference
---------
````
@inproceedings{glocker2023allophant,
    title={Allophant: Cross-lingual Phoneme Recognition with Articulatory Attributes},
    author={Glocker, Kevin and Herygers, Aaricia and Georges, Munir},
    year={2023},
    booktitle={{Proc. Interspeech 2023}},
    month={8}}
````
