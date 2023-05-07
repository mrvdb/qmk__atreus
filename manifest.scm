(use-modules (guix licenses)
             (guix packages)
             (guix download)
             (guix git-download)
             (guix build-system python)
             (guix build-system pyproject))

;; A list of modules which we want to reference in this manifest
(use-package-modules avr
                     base
                     bash
                     certs
                     check

                     gawk
                     compression
                     version-control
                     wget
                     libusb
                     flashing-tools
                     embedded
                     commencement

                     python
                     python-xyz
                     python-build
                     python-check)

;; Define packages which are not yet packaged up in GUIX
(define python-dotty-dict
  (package
    (name "python-dotty-dict")
    (version "1.3.1")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "dotty_dict" version))
              (sha256
               (base32
                "058sah2nyg44xq5wxywlzc3abzcv9fifnlvsflwma9mfp01nw0ab"))))
    (build-system python-build-system)
    (home-page "https://github.com/pawelzny/dotty_dict")
    (synopsis "Dictionary wrapper for quick access to deeply nested keys")
    (description "fork needed?")
    (license expat)))

(define python-log-symbols
  (package
    (name "python-log-symbols")
    (version "0.0.14")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "log_symbols" version))
              (sha256
               (base32
                "0mh5d0igw33libfmbsr1ri1p1y644p36nwaa2w6kzrd8w5pvq2yg"))))
    (build-system python-build-system)
    (arguments
     `(#:phases (modify-phases %standard-phases
                  (add-before 'build 'patch-requirements-dev-txt
                    (lambda _
                      ;; Update requirements from dependency==version
                      ;; to dependency>=version
                      (substitute* "requirements-dev.txt"
                        (("==")
                         ">=")) #t)))))
    (native-inputs (list python-coverage python-nose python-pylint python-tox))
    (propagated-inputs (list python-colorama))
    (home-page "https://github.com/manrajgrover/py-log-symbols")
    (synopsis "Colored symbols for various log levels for Python")
    (description "Colored symbols for various log levels for Python.")
    (license expat)))

(define python-halo
  (package
    (name "python-halo")
    (version "0.0.31")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "halo" version))
              (sha256
               (base32
                "1mn97h370ggbc9vi6x8r6akd5q8i512y6kid2nvm67g93r9a6rvv"))))
    (build-system python-build-system)
    (arguments
     `(#:tests? #f))
    (native-inputs (list
                    python-coverage
                    python-nose
                    python-pylint
                    python-tox
                    ;; FIXME causes powerpc64le not supported? Depends on rust. Sigh.
                    ;python-twine
                    ))
    (propagated-inputs (list
                        python-log-symbols
                        python-spinners
                        python-termcolor
                        python-colorama
                        python-six
                        ))
    (home-page "https://github.com/manrajgrover/halo")
    (synopsis "Beautiful spinners for terminal, IPython and Jupyter")
    (description "Beautiful spinners for terminal, IPython and Jupyter.")
    (license expat)))

(define python-spinners
  (package
    (name "python-spinners")
    (version "0.0.24")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "spinners" version))
              (sha256
               (base32
                "0zz2z6dpdjdq5z8m8w8dfi8by0ih1zrdq0caxm1anwhxg2saxdhy"))))
    (build-system python-build-system)
    (arguments
     `(#:phases (modify-phases %standard-phases
                  (add-before 'build 'patch-requirements-dev-txt
                    (lambda _
                      ;; Update requirements from dependency==version
                      ;; to dependency>=version
                      (substitute* "requirements-dev.txt"
                        (("==")
                         ">=")) #t)))))
    (native-inputs (list python-coverage python-nose python-pylint python-tox))
    (home-page "https://github.com/manrajgrover/py-spinners")
    (synopsis "More than 60 spinners for terminal")
    (description
     "More than 60 spinners for terminal, python wrapper for amazing node library cli-spinners.")
    (license expat)))

(define python-milc
  (package
    (name "python-milc")
    (version "1.6.6")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "milc" version))
              (sha256
               (base32
                "007hdwp659s1wfld92pxdgjz9ijvh949wyf1cbmyzkma30vng8d4"))))
    (build-system python-build-system)
    (propagated-inputs (list
                        python-appdirs
                        python-argcomplete
                        python-colorama ; redundant?
                        python-halo
                        python-spinners
                        ))
    (home-page "https://milc.clueboard.co/")
    (synopsis "Batteries-Included Python 3 CLI Framework")
    (description
     "MILC is a framework for writing CLI applications in Python 3.6+.  It gives you all the features users expect from a modern CLI tool out of the box.")
    (license expat)))

(define python-hjson
  (package
    (name "python-hjson")
    (version "3.0.2")
    (source (origin
              ;; Sources on pypi don't contain data files for tests
              (method git-fetch)
              (uri (git-reference
                    (url "https://github.com/hjson/hjson-py")
                    (commit (string-append "v" version))))
              (file-name (git-file-name name version))
              (sha256
               (base32
                "1jc7j790rcqnhbrfj4lhnz3f6768dc55aij840wmx16jylfqpc2n"))))
    (build-system python-build-system)
    (home-page "http://github.com/hjson/hjson-py")
    (synopsis "Human JSON implementation for Python")
    (description
     "Hjson is a syntax extension to JSON.  It is intended to be used like a user interface for humans, to read and edit before passing the JSON data to the machine.  This package contains a Python library for parsing and generating Hjson.")
    (license expat)))

(define python-hid
  (package
    (name "python-hid")
    (version "1.0.5")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "hid" version))
              (sha256
               (base32
                "1s5hvfbmnlmifswr5514f4xxn5rcd429bdcdqzgwkdxrg9zlx58y"))))
    (build-system python-build-system)
    (arguments
     `(#:modules ((srfi srfi-1)
                  (srfi srfi-26)
                  (guix build utils)
                  (guix build python-build-system))
       #:phases (modify-phases %standard-phases
                  (add-after 'unpack 'fix-hidapi-reference
                    (lambda* (#:key inputs #:allow-other-keys)
                      (substitute* "hid/__init__.py"
                        (("library_paths = \\(")
                         (string-append "library_paths = ('"
                                        (find (negate symbolic-link?)
                                              (find-files (assoc-ref inputs
                                                                     "hidapi")
                                               "^libhidapi-.*\\.so\\..*"))
                                        "',"))) #t)))))
    (inputs (list hidapi))

    (native-inputs `(("python-nose" ,python-nose)))
    (home-page "https://github.com/apmorton/pyhidapi")
    (synopsis "hidapi bindings in ctypes")
    (description "Python wrapper for the hidapi library using ctypes.")
    (license expat)))

(define python-qmk
  (package
    (name "python-qmk")
    (version "1.1.1")
    (source (origin
              (method url-fetch)
              (uri (pypi-uri "qmk" version))
              (sha256
               (base32
                "0s9jfx0ld6w18lxq18x5jxyh03pwzafr50nbz2yzhqfdxc4qw0nx"))))

    (build-system pyproject-build-system)
    (arguments
     `(#:tests? #f))
    (propagated-inputs (list python-pyserial
                             python-pillow
                             python-hid
                             python-pyusb
                             python-milc
                             python-setuptools
                             python-hjson
                             python-jsonschema
                             python-pygments
                             python-dotty-dict))
    (home-page "https://qmk.fm/")
    (synopsis "QMK CLI is a program to help users work with QMK Firmware")
    (description
     "QMK CLI provides various functions for working with QMK Firmware: getting the QMK Firmware sources, setting up the build environment, compiling and flashing the firmware, accessing the debug console provided by the firmware, and many more functions used for the QMK Firmware configuration and development.")
    (license expat)))

;; With the above, create the manifest which is needed in the guix shell
;; See build shell script
(packages->manifest (list nss-certs
                          coreutils
                          bash
                          findutils
                          grep
                          sed
                          gawk
                          unzip
                          zip
                          git
                          wget
                          libusb
                          python-pyusb
                          dfu-programmer
                          dfu-util
                          ;; For the atreus, dont need the arm toolchain and there is a bug that only the last one goes
                          ;; See: https://issues.guix.org/
                          ;; arm-none-eabi-toolchain@6.5.0
                          avr-toolchain
                          glibc
                          gcc-toolchain

                          python
                          python-qmk

                          gnu-make
                          diffutils))
