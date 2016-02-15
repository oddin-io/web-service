<?php
namespace BossEdu\Controller;

use BossEdu\Model\McMaterialQuery;
use BossEdu\Model\Contribution;
use BossEdu\Model\ContributionQuery;
use BossEdu\Model\Map\ContributionTableMap;
use BossEdu\Model\McMaterial;
use BossEdu\Util\Util;
use Jacwright\RestServer\RestException;

class ContributionCtrl
{
    public function authorize()
    {
        return AuthCtrl::check();
    }

    private function insertFile($file, $comment)
    {
        if (isset($file) && !empty($file)) {
            if ($file["error"]) {
                throw new RestException(410, "File error: ".$file["error"]);
            }

            $material = new McMaterial();
            $material->setFile(fopen($file["tmp_name"], "rb"));
            $material->setName(basename($file["name"]));
            $material->setMime($file["type"]);
            $material->setContributionId($comment);
            $material->save();
        }
    }

    /**
     * @url POST /$event/$lecture/$start_date/$class/presentation/$presentation/chat/doubt/$doubt/contribution
     */
    public function newContribution($event, $lecture, $start_date, $class, $presentation, $doubt)
    {
        header("Content-Type: application/json");

        $presentation = urldecode($presentation);
        $doubt = urldecode($doubt);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation, $person, 1)) {
            $data = Util::adjustArrayCase($_POST, "lower");
            $contribution = new Contribution();
            $contribution->fromArray($data, ContributionTableMap::TYPE_FIELDNAME);
            $contribution->setDoubtId($doubt);
            $contribution->setPersonId($person);
            $contribution->save();

            $commentId = $contribution->getId();

            if (isset($_FILES) && !empty($_FILES)) {
                $video = $_FILES["video"];
                $audio = $_FILES["audio"];

                $this->insertFile($video, $commentId);
                $this->insertFile($audio, $commentId);

                foreach ($_FILES["misc"] as $key => $value) {
                    $this->insertFile($value, $commentId);
                }
            }

            echo json_encode($contribution->toArray());
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @url GET /$event/$lecture/$start_date/$class/presentation/$presentation/chat/doubt/$doubt/contribution
     */
    public function getContributions($event, $lecture, $start_date, $class, $presentation, $doubt)
    {
        header("Content-Type: application/json");

        $presentation = urldecode($presentation);
        $doubt = urldecode($doubt);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation, $person, 0)) {
            $contributions = ContributionQuery::create()
                ->join("Contribution.Pessoa")
                ->filterByDoubtId($doubt)
                ->select([
                    "Contribution.Id"
                    , "Contribution.Text"
                    , "Person.Name"
                    , "Contribution.CreatedAt"
                ])
                ->find()
                ->toArray();

            $contributions = ["contributions" =>
                Util::adjustArrayCase(Util::namespacedArrayToNormal($contributions, ["Contribution", "Person"]), "lower")
            ];

            echo json_encode($contributions);
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @url GET /$event/$lecture/$start_date/$class/presentation/$presentation/chat/doubt/$doubt/contribution/$contribution
     */
    public function getContribution($event, $lecture, $start_date, $class, $presentation, $doubt, $contribution)
    {
        header("Content-Type: application/json");

        $presentation = urldecode($presentation);
        $doubt = urldecode($doubt);
        $contribution = urldecode($contribution);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation, $person, 0)) {
            $contributions = ContributionQuery::create()
                ->join("Contribution.Person")
                ->filterByDoubtId($doubt)
                ->filterById($contribution)
                ->select([
                    "Contribution.Id"
                    , "Contribution.Text"
                    , "Person.Name"
                    , "Contribution.CreatedAt"
                ])
                ->findOne();

            $contributions = Util::adjustArrayCase(Util::namespacedArrayToNormal($contributions, ["Contribution", "Person"]), "lower");

            echo json_encode($contributions);
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @url GET /$event/$lecture/$start_date/$class/presentation/$presentation/chat/doubt/$doubt/contribution/$contribution/materials
     */
    public function getContributionMaterials($event, $lecture, $start_date, $class, $presentation, $doubt, $contribution)
    {
        $presentation = urldecode($presentation);
        $contribution = urldecode($contribution);
        $person = $_SESSION["id"];

        if (PresentationCtrl::auth($presentation, $person, 0)) {
            $materials = McMaterialQuery::create()
                ->filterByContributionId($contribution)
                ->select(["Id", "Nome", "Mime"])
                ->find();

            $materials = ["materials" =>
                Util::adjustArrayCase($materials, "lower")
            ];
            echo json_encode($materials);
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }

    /**
     * @url GET /$event/$lecture/$start_date/$class/presentation/$presentation/chat/doubt/$doubt/contribution/$contribution/materials/$material
     */
    public function getContributionMaterial($event, $lecture, $start_date, $class, $presentation, $doubt, $contribution, $material)
    {
        $presentation = urldecode($presentation);
        $person = $_SESSION["id"];
        $contribution = urldecode($contribution);
        $material = urldecode($material);

        if (PresentationCtrl::auth($presentation, $person, 0)) {
            $material = McMaterialQuery::create()
                ->findOneById($material);

            if ($material) {
                header("Content-Type: ".$material->getMime());
                header("Content-Disposition: attachment; filename=\"".$material->getName()."\"");
                header("Cache-Control: no-cache, no-store, must-revalidate");
                header("Pragma: no-cache");
                header("Expires: 0");
                fpassthru($material->getFile());
                exit(0);
            } else {
                throw new RestException(404, "File");
            }
        } else {
            throw new RestException(401, "Unauthorized");
        }
    }
}
