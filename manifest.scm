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
                     python-check
                     terminals
                     firmware)

;; Define packages which are not yet packaged up in GUIX

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
                          (make-avr-toolchain)
                          glibc
                          gcc-toolchain

                          python
                          python-qmk

                          gnu-make
                          diffutils))
