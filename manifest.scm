(use-modules (guix licenses)
             (guix packages)
             (guix download)
             (guix transformations)
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
                     flashing-tools     ; dfu-programmer
                     commencement       ; gcc-toolchain
                     )

;; Allow specifying a list of packages not to test when building a package
(define (no-tests donttest package)
  ((options->transformation
   (map (lambda (p) `(without-tests . ,p)) donttest))
   (specification->package package)))

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

                          ;; Skip tests on some packages, seems harmless in the firmware context so far
                          (no-tests '("python-requests-toolbelt"
                                      "python-werkzeug")
                                    "qmk")

                          gnu-make
                          diffutils))
